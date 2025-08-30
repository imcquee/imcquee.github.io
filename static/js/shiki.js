import { codeToHtml } from "https://esm.sh/shiki@3.0.0";

document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll("code").forEach(async (el) => {
    const codeBlock = el;
    const code = codeBlock.textContent ?? "";
    const lang = codeBlock.dataset.lang ?? "txt";

    const html = await codeToHtml(code, {
      lang,
      theme: "github-light",
      meta: {
        class: "p-4 bg-white whitespace-pre-wrap break-words",
      },
    });

    codeBlock.innerHTML = html;
  });
});
