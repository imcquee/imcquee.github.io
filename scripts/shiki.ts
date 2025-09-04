import { codeToHtml } from "shiki";
import { glob } from "glob";
import { readFile, writeFile } from "node:fs/promises";
import { parseHTML } from "linkedom";
import {
  transformerNotationHighlight,
  transformerNotationDiff,
} from "@shikijs/transformers";

function detectLang(codeEl: Element): string {
  const dl = codeEl.getAttribute("data-lang");
  if (dl) return dl;
  return "txt";
}

async function highlightHtml(html: string): Promise<string> {
  const { document } = parseHTML(html);
  const nodeList = document.querySelectorAll("pre > code");
  const nodes = Array.from(nodeList);

  for (const codeEl of nodes) {
    const pre = codeEl.parentElement;
    if (!pre) continue;

    const code = codeEl.textContent ?? "";
    const lang = detectLang(codeEl);

    const shikiHtml = await codeToHtml(code, {
      lang,
      theme: "github-light",
      meta: { class: "p-4 whitespace-pre-wrap break-words" },
      transformers: [transformerNotationDiff(), transformerNotationHighlight()],
    });

    const wrapper = document.createElement("div");
    wrapper.innerHTML = shikiHtml;

    const childNodesArray = Array.from(wrapper.childNodes);
    pre.replaceWith(...childNodesArray);
  }

  return document.toString();
}

const files = await glob("priv/**/*.html", { nodir: true });

for (const file of files) {
  const html = await readFile(file, "utf8");
  const out = await highlightHtml(html);
  await writeFile(file, out, "utf8");
}
