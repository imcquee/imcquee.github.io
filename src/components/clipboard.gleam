import gleam/javascript/array
import gleam/list
import grille_pain
import grille_pain/options
import grille_pain/toast
import lustre/attribute
import lustre/element as lustre_element
import lustre/element/html
import plinth/browser/clipboard
import plinth/browser/document
import plinth/browser/element

pub fn get_script() -> lustre_element.Element(a) {
  html.script(
    [
      attribute.attribute("type", "module"),
    ],
    "import{main}from'/js/clipboard.js';document.addEventListener(\"DOMContentLoaded\",()=>{main({})});",
  )
}

pub fn main() {
  let elements =
    document.query_selector_all("[copy_button]")
    |> array.to_list()

  let assert Ok(_) =
    options.default() |> options.timeout(2000) |> grille_pain.setup()

  list.map(elements, fn(element) {
    let assert Ok(copy_text) = element.get_attribute(element, "data-copy")

    element.add_event_listener(element, "click", fn(_) {
      clipboard.write_text(copy_text)
      toast.info("Copied!")
      Nil
    })
  })
}
