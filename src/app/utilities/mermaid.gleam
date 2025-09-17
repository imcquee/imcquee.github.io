import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn get_script() -> List(Element(a)) {
  [
    html.script(
      [attribute.src("/js/mermaid.tiny.js"), attribute.attribute("defer", "")],
      "",
    ),
    html.script(
      [],
      "window.addEventListener(\"DOMContentLoaded\", () => {window.mermaid?.initialize({ startOnLoad: true });});",
    ),
  ]
}
