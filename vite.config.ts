import { defineConfig, ViteDevServer, Plugin } from "vite";
import gleam from "vite-gleam";
import { spawn, ChildProcess } from "node:child_process";
import { readdirSync } from "fs";
import * as fs from "node:fs";
import * as path from "node:path";

const CSS_IN = "static/website.css";
const CSS_OUT_TMP = path.resolve(".dev/output.css");
const CSS_OUT = path.resolve("priv/output.css");
const jsDir = path.resolve("js");
const entryPoints: Record<string, string> = {};

function run(cmd: string, args: string[], opts: object = {}): Promise<boolean> {
  return new Promise((resolve) => {
    const proc = spawn(cmd, args, { stdio: "inherit", ...opts });
    proc.on("close", (code) => resolve(code === 0));
  });
}

function copyCssIntoPriv(): void {
  fs.mkdirSync(path.dirname(CSS_OUT), { recursive: true });
  if (fs.existsSync(CSS_OUT_TMP)) {
    fs.copyFileSync(CSS_OUT_TMP, CSS_OUT);
  }
}

function makeDebounce(ms: number): (fn: () => void) => void {
  let t: NodeJS.Timeout | null = null;
  return (fn: () => void) => {
    if (t) clearTimeout(t);
    t = setTimeout(fn, ms);
  };
}

function devPlugin(): Plugin {
  let building = false;
  let tailwindProc: ChildProcess | null = null;
  const debounceBuild = makeDebounce(100);
  const debounceCss = makeDebounce(50);

  const startTailwindWatch = async (): Promise<void> => {
    if (tailwindProc) return;
    fs.mkdirSync(path.dirname(CSS_OUT_TMP), { recursive: true });
    tailwindProc = spawn(
      "tailwindcss",
      ["-i", CSS_IN, "-o", CSS_OUT_TMP, "--watch"],
      { stdio: "inherit" },
    );

    fs.watch(path.dirname(CSS_OUT_TMP), { persistent: true }, (_evt, f) => {
      if (f === path.basename(CSS_OUT_TMP)) copyCssIntoPriv();
    });

    const kill = (): void => {
      if (tailwindProc && !tailwindProc.killed) {
        tailwindProc.kill();
      }
    };

    process.on("exit", kill);
    process.on("SIGINT", () => {
      kill();
      process.exit();
    });
    process.on("SIGTERM", () => {
      kill();
      process.exit();
    });

    tailwindProc.on("exit", () => {
      tailwindProc = null;
    });
  };

  const buildGleamThenSyncCss = async (
    server: ViteDevServer,
    { reload = true }: { reload?: boolean } = {},
  ): Promise<void> => {
    if (building) return;
    building = true;
    const ok = await run("gleam", ["run", "-m", "build"]);
    await run("bun", ["run", "scripts/shiki.ts"]);
    copyCssIntoPriv();
    if (ok && reload) {
      server.ws.send({ type: "full-reload" });
    }
    building = false;
  };

  return {
    name: "gleam-tailwind",
    async configureServer(server: ViteDevServer) {
      copyCssIntoPriv();
      await buildGleamThenSyncCss(server, { reload: false });
      await startTailwindWatch();

      server.watcher.add("src");
      server.watcher.add("posts");
      server.watcher.add(CSS_IN);

      server.watcher.on("change", (file: string) => {
        if (file.endsWith(".gleam") || file.endsWith(".djot")) {
          debounceBuild(() => buildGleamThenSyncCss(server, { reload: true }));
        } else if (file.endsWith("website.css")) {
          debounceCss(copyCssIntoPriv);
        }
      });

      server.httpServer?.once("close", () => {
        if (tailwindProc && !tailwindProc.killed) {
          tailwindProc.kill();
        }
      });
    },
  };
}

const jsFiles = readdirSync(jsDir).filter((file) => file.endsWith(".js"));
jsFiles.forEach((file) => {
  const name = file.replace(".js", "");
  entryPoints[name] = path.join(jsDir, file);
});

export default defineConfig({
  root: "./priv",
  plugins: [devPlugin(), gleam()],
  server: {
    watch: { ignored: [] },
  },
  build: {
    rollupOptions: {
      input: entryPoints,
      output: {
        dir: "./static/js",
        entryFileNames: "[name].js",
      },
    },
  },
});
