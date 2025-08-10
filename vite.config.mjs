import { defineConfig } from "vite";
import { spawn } from "node:child_process";

const CSS_IN = "static/website.css";
const CSS_OUT = "priv/output.css";

function run(cmd, args) {
  return new Promise((resolve) => {
    const proc = spawn(cmd, args, { stdio: "inherit" });
    proc.on("close", (code) => resolve(code === 0));
  });
}

function devPlugin() {
  let building = false;
  
  const buildAll = async (server) => {
    if (building) return;
    building = true;
    
    const gleamOk = await run("gleam", ["run", "-m", "build"]);
    if (gleamOk) {
      await run("tailwindcss", ["-i", CSS_IN, "-o", CSS_OUT, "--content", "src/**/*.gleam"]);
      server.ws.send({ type: "full-reload" });
    }
    
    building = false;
  };

  const buildCss = async (server) => {
    await run("tailwindcss", ["-i", CSS_IN, "-o", CSS_OUT, "--content", "src/**/*.gleam"]);
    server.ws.send({ type: "full-reload" });
  };

  return {
    name: "gleam-tailwind",
    async configureServer(server) {
      await run("tailwindcss", ["-i", CSS_IN, "-o", CSS_OUT, "--content", "src/**/*.gleam"]);
      server.watcher.add("src");
      server.watcher.add(CSS_IN);
      
      server.watcher.on("change", (file) => {
        if (file.endsWith(".gleam")) {
          buildAll(server);
        } else if (file.endsWith("website.css")) {
          buildCss(server);
        }
      });
    },
  };
}

export default defineConfig({
  root: "./priv",
  plugins: [devPlugin()],
  server: {
    watch: {
      ignored: ["**/output.css"]
    }
  }
});
