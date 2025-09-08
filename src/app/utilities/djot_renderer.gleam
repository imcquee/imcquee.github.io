import gleam/dict
import gleam/list
import gleam/option
import gleam/regexp
import gleam/string
import jot
import lustre/attribute.{class}
import lustre/element.{type Element}
import lustre/element/html
import lustre/ssg/djot.{type Renderer}
import stateless_components/code
import stateless_components/link

fn linkify(text: String) -> String {
  let assert Ok(re) = regexp.from_string(" +")

  text
  |> regexp.split(re, _)
  |> string.join("-")
}

pub fn custom_renderer() -> Renderer(Element(msg)) {
  djot.Renderer(
    ..djot.default_renderer(),
    codeblock: fn(attrs, lang, code) {
      let lang = option.unwrap(lang, "text")
      let not_copyable = dict.has_key(attrs, "not_copyable")
      let assert Ok(title) = dict.get(attrs, "title")
        as "Please title this codeblock ex. {title='hello_world.gleam'}"
      code.render_code_snippet(title:, code:, lang:, attrs:, not_copyable:)
    },
    heading: fn(_, level, content) {
      case level {
        1 -> html.h1([class("py-2 text-3xl font-bold")], content)
        2 -> html.h2([class("py-2 text-2xl font-bold")], content)
        3 -> html.h3([class("py-2 text-xl font-bold")], content)
        _ -> html.p([class("py-2 font-bold")], content)
      }
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
    link: fn(destination, references, content) {
      case destination {
        jot.Reference(ref) ->
          case dict.get(references, ref) {
            Ok(url) -> html.a([attribute.href(url)], content)
            Error(_) ->
              html.a(
                [
                  attribute.href("#" <> linkify(ref)),
                  attribute.id(linkify("back-to-" <> ref)),
                ],
                content,
              )
          }
        jot.Url(url) ->
          link.render_link(
            link.External(url),
            [class("text-blue-700 underline")],
            content,
          )
      }
    },
  )
}
