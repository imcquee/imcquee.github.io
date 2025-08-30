import gleam/dict
import gleam/list
import gleam/option
import jot
import lustre/attribute.{class}
import lustre/element.{type Element}
import lustre/element/html
import lustre/ssg/djot.{type Renderer}
import stateless_components/code

pub fn custom_renderer() -> Renderer(Element(msg)) {
  djot.Renderer(
    ..djot.default_renderer(),
    codeblock: fn(attrs, lang, code) {
      let lang = option.unwrap(lang, "text")
      let assert Ok(title) = dict.get(attrs, "title")
        as "Please title this codeblock ex. {title='hello_world.gleam'}"
      code.render_code_snippet(title:, code:, lang:, attrs:)
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
