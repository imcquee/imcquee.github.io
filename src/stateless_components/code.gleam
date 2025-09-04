import gleam/dict.{type Dict}
import lustre/attribute.{attribute, class}
import lustre/element
import lustre/element/html

fn to_attributes(attrs) {
  use attrs, key, val <- dict.fold(attrs, [])
  [attribute(key, val), ..attrs]
}

pub fn render_code_snippet(
  title title: String,
  code code: String,
  lang lang: String,
  attrs attrs: Dict(String, String),
) {
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
        [
          html.p([class("text-xl")], [element.text(title)]),
          html.button(
            [
              class(
                "cursor-pointer hover:scale-120 transition-transform duration-200",
              ),

              attribute.attribute("data-copy", code),
            ],
            [
              html.p([class("text-2xl")], [element.text("📋")]),
            ],
          ),
        ],
      ),
      html.pre(to_attributes(attrs), [
        html.code([attribute("data-lang", lang)], [html.text(code)]),
      ]),
    ],
  )
}
