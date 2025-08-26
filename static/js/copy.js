document.addEventListener("DOMContentLoaded", () => {
  async function notify(message, variant = "success", icon = "check2-circle", duration = 2000) {
    const alert = Object.assign(document.createElement("sl-alert"), {
      variant,
      closable: true,
      duration,
      innerHTML: `
        <sl-icon name="${icon}" slot="icon"></sl-icon>
        ${message}
      `,
    });

    document.body.append(alert);
    await customElements.whenDefined("sl-alert");
    return alert.toast();
  }

  document.querySelectorAll("[data-copy]").forEach(el => {
    el.addEventListener("click", async () => {
      const text = el.dataset.copy;
      try {
        await navigator.clipboard.writeText(text);
        notify("Copied!", "success", "check2-circle");
        console.log("Copied:", text);
      } catch (err) {
        notify("Copy failed", "danger", "exclamation-octagon");
        console.error("Copy failed:", err);
      }
    });
  });
});
