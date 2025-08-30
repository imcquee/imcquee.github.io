import { codeToHtml } from "shiki";
import { glob } from "glob";
import { readFile, writeFile } from "node:fs/promises";
import { parseHTML } from "linkedom";

function detectLang(codeEl: Element): string {
  const dl = codeEl.getAttribute("data-lang");
  if (dl) return dl;
  return "txt";
}

async function highlightHtml(html: string): Promise<string> {
  const { document } = parseHTML(html);
  const nodes = [...document.querySelectorAll("pre > code")];

  for (const codeEl of nodes) {
    const pre = codeEl.parentElement;
    if (!pre) continue;

    const code = codeEl.textContent ?? "";
    const lang = detectLang(codeEl);

    const shikiHtml = await codeToHtml(code, {
      lang,
      theme: "github-light",
      meta: { class: "p-4 bg-white whitespace-pre-wrap break-words" },
    });

    const wrapper = document.createElement("div");
    wrapper.innerHTML = shikiHtml;
    pre.replaceWith(...wrapper.childNodes);
  }

  return document.toString();
}

const files = await glob("priv/**/*.html", { nodir: true });

for (const file of files) {
  const html = await readFile(file, "utf8");
  const out = await highlightHtml(html);
  await writeFile(file, out, "utf8");
}
