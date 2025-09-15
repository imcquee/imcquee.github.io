import lustre/attribute.{class}
import lustre/element/html

pub fn render_discus() {
  html.div([class("w-full px-2 lg:p-0 lg:w-4/5")], [
    html.script(
      [
        attribute.src("https://giscus.app/client.js"),
        attribute.attribute("data-repo", "imcquee/imcquee.github.io"),
        attribute.attribute("data-repo-id", "R_kgDONpQt6w"),
        attribute.attribute("data-category-id", "Announcements"),
        attribute.attribute("data-mapping", "pathname"),
        attribute.attribute("data-strict", "0"),
        attribute.attribute("data-reactions-enabled", "1"),
        attribute.attribute("data-emit-metadata", "0"),
        attribute.attribute("data-input-position", "bottom"),
        attribute.attribute("data-theme", "light"),
        attribute.attribute("data-lang", "en"),
        attribute.attribute("data-loading", "lazy"),
        attribute.attribute("crossorigin", "anonymous"),
        attribute.attribute("async", ""),
      ],
      "",
    ),
  ])
}
