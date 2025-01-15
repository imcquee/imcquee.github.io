import gleam/list
import lustre/attribute.{attribute, class}
import lustre/element.{type Element}
import lustre/element/html
import lustre/ui

pub type Page {
  Page(title: String, content: List(Content))
}

pub type Content {
  Title(String)
  Heading(String)
  Subheading(String)
  Section(List(InlineContent))
  Snippet(lang: String, code: String)
}

pub type InlineContent {
  Bold(String)
  Code(String)
  Link(href: String, text: String)
  Text(String)
}

pub fn view_page(page: Page) -> Element(msg) {
  html.html([attribute.property("lang", "en")], [head(), body(page)])
}

fn body(page: Page) -> Element(a) {
  html.body([class("h-screen w-screen bg-slate-800")], [
    html.header([], [
      html.a([attribute.href("./index.html")], [
        html.h1([class("text-2xl p-8 font-mono text-white")], [
          element.text("imcquee"),
        ]),
      ]),
    ]),
    ui.centre(
      [class("py-12")],
      ui.stack([], [
        ui.centre(
          [class("w-screen")],
          html.main(
            [attribute.class("container"), class("px-12")],
            list.map(page.content, view),
          ),
        ),
      ]),
    ),
  ])
}

fn head() -> Element(a) {
  html.head([], [
    html.link([
      attribute.href("./lustre_ui.css"),
      attribute.type_("text/css"),
      attribute.rel("stylesheet"),
    ]),
    html.link([
      attribute.href("./custom.css"),
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
        "https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap",
      ),
    ]),
    // html.script([attribute.src("https://cdn.tailwindcss.com")], ""),
  ])
}

pub fn view(content: Content) -> Element(msg) {
  case content {
    Title(text) ->
      html.h1([class("text-5xl font-mono text-white")], [element.text(text)])
    Heading(text) -> html.h2([], [element.text(text)])
    Subheading(text) ->
      html.h3([class("py-8 font-mono text-white")], [element.text(text)])
    Section(content) ->
      html.p(
        [class("py-4 text-2xl font-outfit text-white")],
        list.map(content, view_inline),
      )
    Snippet(lang, code) ->
      html.pre([attribute("data-lang", lang)], [
        html.code([], [element.text(code)]),
      ])
  }
}

fn view_inline(content: InlineContent) -> Element(msg) {
  case content {
    Bold(text) -> html.strong([], [element.text(text)])
    Code(text) -> html.code([], [element.text(text)])
    Link(href, text) -> html.a([attribute("href", href)], [element.text(text)])
    Text(text) -> element.text(text)
  }
}
