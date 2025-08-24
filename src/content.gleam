import lustre/attribute.{class}
import lustre/element.{type Element}
import lustre/element/html

pub fn view_home(home_content: Element(msg)) -> Element(msg) {
  html.html([attribute.lang("en")], [
    head(),
    html.body([class("h-screen w-screen bg-fuchsia-100")], [
      html.main([], [home_content]),
    ]),
  ])
}

pub fn view_page(content: Element(a)) -> Element(a) {
  html.html([attribute.lang("en")], [head(), body(content)])
}

fn body(content: Element(a)) -> Element(a) {
  html.body([class("h-screen w-screen bg-fuchsia-100")], [
    html.header([], [
      html.a(
        [
          attribute.href("/index.html"),
          class("flex flex-row p-4 gap-2 items-center"),
        ],
        [
          html.img([
            attribute.src("/images/city.png"),
            class("object-cover h-10 w-10 rounded-full"),
          ]),
          html.h1([class("text-2xl font-mono text-black")], [
            element.text("imcquee"),
          ]),
        ],
      ),
    ]),
    html.div([], [
      html.div([class("w-screen h-screen")], [
        html.main([class("pb-12")], [content]),
      ]),
    ]),
  ])
}

fn head() -> Element(a) {
  html.head([], [
    html.meta([attribute.charset("UTF-8")]),
    html.meta([
      attribute.name("description"),
      attribute.content("Isaac McQueen's Personal Profile and Blog"),
    ]),
    html.meta([
      attribute.name("viewport"),
      attribute.content("width=device-width, initial-scale=1.0"),
    ]),
    html.link([
      attribute.rel("apple-touch-icon"),
      attribute.sizes("180x180"),
      attribute.href("/images/apple-touch-icon.png"),
    ]),
    html.link([
      attribute.rel("icon"),
      attribute.sizes("32x32"),
      attribute.href("/images/favicon-32x32.png"),
    ]),
    html.link([
      attribute.rel("icon"),
      attribute.sizes("16x16"),
      attribute.href("/images/favicon-16x16.png"),
    ]),
    html.link([
      attribute.rel("manifest"),
      attribute.href("/images/site.webmanifest"),
    ]),
    html.link([
      attribute.href("/output.css"),
      attribute.type_("text/css"),
      attribute.rel("stylesheet"),
    ]),
    html.link([
      attribute.rel("stylesheet"),
      attribute.href(
        "https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@2.20.1/cdn/themes/light.css",
      ),
    ]),
    html.script(
      [
        attribute.attribute("type", "module"),
        attribute.src(
          "https://cdn.jsdelivr.net/npm/@shoelace-style/shoelace@2.20.1/cdn/shoelace-autoloader.js",
        ),
      ],
      "",
    ),
  ])
}
