import gleam/dict.{type Dict}
import lustre/attribute.{attribute, class}
import lustre/element
import lustre/element/html
import stateless_components/copy_button

fn to_attributes(attrs) {
  use attrs, key, val <- dict.fold(attrs, [])
  [attribute(key, val), ..attrs]
}

pub fn render_code_snippet(
  title title: String,
  code code: String,
  lang lang: String,
  attrs attrs: Dict(String, String),
  not_copyable not_copyable: Bool,
) {
  let display_copy = case not_copyable {
    True -> element.none()
    False -> copy_button.render_copy_button(code)
  }

  html.div(
    [
      class("flex flex-col my-4 border-1 border-black"),
    ],
    [
      html.div(
        [
          class(
            "flex flex-row p-2 bg-white border-b-1 border-black justify-between",
          ),
        ],
        [html.p([class("text-xl")], [element.text(title)]), display_copy],
      ),
      html.pre(to_attributes(attrs), [
        html.code([attribute("data-lang", lang)], [html.text(code)]),
      ]),
    ],
  )
}
