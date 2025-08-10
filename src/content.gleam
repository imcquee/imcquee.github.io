import gleam/list
import lustre/attribute.{attribute, class}
import lustre/element.{type Element}
import lustre/element/html

pub type Page {
  Page(title: String, content: List(Content))
}

pub type Dimensions {
  Height(Int)
  Width(Int)
}

pub type Content {
  Date(String)
  Title(String)
  Section(List(InlineContent))
}

pub type InlineContent {
  Bold(String)
  Code(String)
  Link(href: String, text: String)
  Text(String)
  Image(size: Dimensions, src: String)
}

pub fn view_home(home_content: Element(msg)) -> Element(msg) {
  html.html([attribute.lang("en")], [
    head(),
    html.body([class("h-screen w-screen bg-fuchsia-100")], [home_content]),
  ])
}

pub fn view_page(page: Page) -> Element(msg) {
  html.html([attribute.lang("en")], [head(), body(page)])
}

fn body(page: Page) -> Element(a) {
  html.body([class("h-screen w-screen bg-fuchsia-100")], [
    html.header([], [
      html.a([attribute.href("./index.html")], [
        html.h1([class("text-2xl p-8 font-mono text-black")], [
          element.text("imcquee"),
        ]),
      ]),
    ]),
    html.div([class("py-12")], [
      html.div([], [
        html.div([class("w-screen")], [
          html.main(
            [attribute.class("container"), class("px-12")],
            list.map(page.content, view),
          ),
        ]),
      ]),
    ]),
  ])
}

fn head() -> Element(a) {
  html.head([], [
    html.meta([attribute.charset("UTF-8")]),
    html.meta([
      attribute.name("viewport"),
      attribute.content("width=device-width, initial-scale=1.0"),
    ]),
    // html.link([
    //   attribute.href("./custom.css"),
    //   attribute.type_("text/css"),
    //   attribute.rel("stylesheet"),
    // ]),
    html.link([
      attribute.href("./output.css"),
      attribute.type_("text/css"),
      attribute.rel("stylesheet"),
    ]),
    html.link([
      attribute.href("https://fonts.googleapis.com"),
      attribute.rel("preconnect"),
    ]),
    html.link([
      attribute("crossorigin", ""),
      attribute.href("https://fonts.gstatic.com"),
      attribute.rel("preconnect"),
    ]),
    html.link([
      attribute.rel("stylesheet"),
      attribute.href(
        "https://fonts.googleapis.com/css2?family=JetBrains+Mono:ital,wght@0,100..800;1,100..800&family=Kanchenjunga:wght@400;500;600;700&family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap",
      ),
    ]),
  ])
}

pub fn view(content: Content) -> Element(msg) {
  case content {
    Title(text) ->
      html.h1([class("text-5xl font-mono text-black")], [element.text(text)])
    Date(text) ->
      html.h1([class("text-5xl font-mono text-black")], [element.text(text)])
    Section(content) ->
      html.p(
        [class("py-4 text-2xl font-outfit text-black")],
        list.map(content, view_inline),
      )
  }
}

fn view_inline(content: InlineContent) -> Element(msg) {
  case content {
    Bold(text) -> html.strong([], [element.text(text)])
    Code(text) -> html.code([], [element.text(text)])
    Link(href, text) -> html.a([attribute("href", href)], [element.text(text)])
    Text(text) -> element.text(text)
    Image(size, src) ->
      html.img([
        attribute("src", src),
        attribute("height", "300"),
        attribute("width", "300"),
      ])
  }
}
