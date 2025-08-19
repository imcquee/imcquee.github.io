import gleam/dict
import gleam/list
import gleam/option
import jot
import lustre/attribute.{attribute, class}
import lustre/element.{type Element}
import lustre/element/html
import lustre/ssg/djot.{type Renderer}

fn to_attributes(attrs) {
  use attrs, key, val <- dict.fold(attrs, [])
  [attribute(key, val), ..attrs]
}

pub fn custom_renderer() -> Renderer(Element(msg)) {
  djot.Renderer(
    ..djot.default_renderer(),
    codeblock: fn(attrs, lang, code) {
      let lang = option.unwrap(lang, "text")
      html.div([class("my-4 p-4 rounded-md border-2 border-black")], [
        html.pre(to_attributes(attrs), [
          html.code([attribute("data-lang", lang)], [html.text(code)]),
        ]),
      ])
    },
    bullet_list: fn(layout, style, items) {
      let list_style_type =
        attribute.style("list-style-type", case style {
          "*" -> "disc"
          _ -> "circle"
        })

      html.ul([list_style_type, class("ml-4")], {
        list.map(items, fn(item) {
          case layout {
            jot.Tight -> html.li([], item)
            jot.Loose -> html.li([], [html.p([], item)])
          }
        })
      })
    },
  )
}
