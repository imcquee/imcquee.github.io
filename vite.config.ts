import { defineConfig, type ViteDevServer, type Plugin } from "vite";
import { spawn, type ChildProcess } from "node:child_process";
import { mkdirSync, existsSync, copyFileSync, watch } from "node:fs";
import { resolve, dirname, basename, join } from "node:path";

// Configuration constants
const PATHS = {
  cssInput: "website.css",
  cssTempOutput: resolve(".dev/output.css"),
  cssOutput: resolve("priv/output.css"),
  srcDir: "src",
  postsDir: "posts",
} as const;

// Utility functions
function runCommand(cmd: string, args: string[]): Promise<boolean> {
  return new Promise((resolve) => {
    const proc = spawn(cmd, args, { stdio: "inherit" });
    proc.on("close", (code) => resolve(code === 0));
  });
}

function createDebouncer(delay: number) {
  let timeout: NodeJS.Timeout | null = null;
  return (fn: () => void) => {
    if (timeout) clearTimeout(timeout);
    timeout = setTimeout(fn, delay);
  };
}

function copyCssToOutput(): void {
  mkdirSync(dirname(PATHS.cssOutput), { recursive: true });
  if (existsSync(PATHS.cssTempOutput)) {
    copyFileSync(PATHS.cssTempOutput, PATHS.cssOutput);
  }
}

// Main plugin
function createDevPlugin(): Plugin {
  let isBuilding = false;
  let tailwindProcess: ChildProcess | null = null;

  const debounceBuild = createDebouncer(100);
  const debounceCss = createDebouncer(50);

  async function startTailwindWatcher(): Promise<void> {
    if (tailwindProcess) return;

    // Ensure temp directory exists
    mkdirSync(dirname(PATHS.cssTempOutput), { recursive: true });

    // Start Tailwind CSS watcher
    tailwindProcess = spawn(
      "tailwindcss",
      ["-i", PATHS.cssInput, "-o", PATHS.cssTempOutput, "--watch"],
      { stdio: "inherit" },
    );

    // Watch for Tailwind output changes
    watch(dirname(PATHS.cssTempOutput), { persistent: true }, (_, filename) => {
      if (filename === basename(PATHS.cssTempOutput)) {
        copyCssToOutput();
      }
    });

    // Setup cleanup handlers
    const cleanup = () => {
      if (tailwindProcess && !tailwindProcess.killed) {
        tailwindProcess.kill();
      }
    };

    process.on("exit", cleanup);
    process.on("SIGINT", () => {
      cleanup();
      process.exit();
    });
    process.on("SIGTERM", () => {
      cleanup();
      process.exit();
    });

    tailwindProcess.on("exit", () => {
      tailwindProcess = null;
    });
  }

  async function buildGleamAndSyncCss(
    server: ViteDevServer,
    shouldReload = true,
  ): Promise<void> {
    if (isBuilding) return;

    isBuilding = true;
    const debounceBuild = createDebouncer(100);
    try {
      const gleamSuccess = await runCommand("gleam", ["run", "-m", "build"]);
      await runCommand("bun", ["run", "scripts/shiki.ts"]);
      copyCssToOutput();

      if (gleamSuccess && shouldReload) {
        debounceBuild(() => server.ws.send({ type: "full-reload" }));
      }
    } finally {
      isBuilding = false;
    }
  }

  return {
    name: "gleam-tailwind-dev",

    async configureServer(server: ViteDevServer) {
      // Initial setup
      copyCssToOutput();
      await buildGleamAndSyncCss(server, false);
      await startTailwindWatcher();

      // Setup file watchers
      server.watcher.add(PATHS.srcDir);
      server.watcher.add(PATHS.postsDir);
      server.watcher.add(PATHS.cssInput);

      // Handle file changes
      server.watcher.on("change", (filePath: string) => {
        if (filePath.endsWith(".gleam") || filePath.endsWith(".djot")) {
          debounceBuild(() => buildGleamAndSyncCss(server, true));
        } else if (filePath.endsWith("website.css")) {
          debounceCss(copyCssToOutput);
        }
      });

      // Cleanup on server close
      server.httpServer?.once("close", () => {
        if (tailwindProcess && !tailwindProcess.killed) {
          tailwindProcess.kill();
        }
      });
    },
  };
}

// Export configuration
export default defineConfig(async () => ({
  root: "./priv",
  plugins: [createDevPlugin()],
  server: {
    watch: { ignored: [] },
  },
}));
