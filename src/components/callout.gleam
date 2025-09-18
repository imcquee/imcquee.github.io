import gleam/javascript/array
import gleam/list
import lustre/attribute
import lustre/element as lustre_element
import lustre/element/html
import plinth/browser/document
import plinth/browser/element

pub fn get_script() -> lustre_element.Element(a) {
  html.script(
    [
      attribute.attribute("type", "module"),
    ],
    "import{main}from'/js/callout.js';document.addEventListener(\"DOMContentLoaded\",()=>{main({})});",
  )
}

pub fn main() {
  let elements =
    document.query_selector_all("[callout]")
    |> array.to_list()

  list.map(elements, fn(element) {
    let inner_html =
      html.p([], [lustre_element.text("Hello Paul")])
      |> lustre_element.to_string()

    element.set_inner_html(element, inner_html)
  })
}
