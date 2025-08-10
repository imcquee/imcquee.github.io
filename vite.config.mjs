import { defineConfig } from "vite";
import { spawn } from "node:child_process";
import * as fs from "node:fs";
import * as path from "node:path";

const CSS_IN = "static/website.css";
const CSS_OUT_TMP = path.resolve("dev/output.css");
const CSS_OUT = path.resolve("priv/output.css");

function run(cmd, args, opts = {}) {
  return new Promise((resolve) => {
    const proc = spawn(cmd, args, { stdio: "inherit", ...opts });
    proc.on("close", (code) => resolve(code === 0));
  });
}

function copyCssIntoPriv() {
  fs.mkdirSync(path.dirname(CSS_OUT), { recursive: true });
  if (fs.existsSync(CSS_OUT_TMP)) {
    fs.copyFileSync(CSS_OUT_TMP, CSS_OUT);
  }
}

function makeDebounce(ms) {
  let t = null;
  return (fn) => {
    if (t) clearTimeout(t);
    t = setTimeout(fn, ms);
  };
}

function devPlugin() {
  let building = false;
  let tailwindProc = null;
  const debounceBuild = makeDebounce(100);
  const debounceCss = makeDebounce(50);

  const startTailwindWatch = async () => {
    if (tailwindProc) return;

    fs.mkdirSync(path.dirname(CSS_OUT_TMP), { recursive: true });

    tailwindProc = spawn(
      "tailwindcss",
      ["-i", CSS_IN, "-o", CSS_OUT_TMP, "--watch"],
      { stdio: "inherit" }
    );

    fs.watch(path.dirname(CSS_OUT_TMP), { persistent: true }, (_evt, f) => {
      if (f === path.basename(CSS_OUT_TMP)) copyCssIntoPriv();
    });
    const kill = () => {
      if (tailwindProc && !tailwindProc.killed) {
        tailwindProc.kill();
      }
    };
    process.on("exit", kill);
    process.on("SIGINT", () => { kill(); process.exit(); });
    process.on("SIGTERM", () => { kill(); process.exit(); });

    tailwindProc.on("exit", () => { tailwindProc = null; });
  };

  const buildGleamThenSyncCss = async (server) => {
    if (building) return;
    building = true;
    const ok = await run("gleam", ["run", "-m", "build"]);
    copyCssIntoPriv();
    if (ok) server.ws.send({ type: "full-reload" });
    building = false;
  };

  return {
    name: "gleam-tailwind",
    async configureServer(server) {
      await startTailwindWatch();
      copyCssIntoPriv();

      server.watcher.add("src");
      server.watcher.add(CSS_IN);

      server.watcher.on("change", (file) => {
        if (file.endsWith(".gleam")) {
          debounceBuild(() => buildGleamThenSyncCss(server));
        } else if (file.endsWith("website.css")) {
          debounceCss(() => {
            copyCssIntoPriv();
          });
        }
      });

      server.httpServer?.once("close", () => {
        if (tailwindProc && !tailwindProc.killed) {
          try { tailwindProc.kill(); } catch {}
        }
      });
    },
  };
}

export default defineConfig({
  root: "./priv",
  plugins: [devPlugin()],
  server: {
    watch: { ignored: [] },
  },
});
