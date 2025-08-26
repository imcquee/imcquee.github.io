import lustre/attribute.{class}
import lustre/element.{type Element}
import lustre/element/html
import stateless_components/link

pub fn view_home(home_content: Element(msg)) -> Element(msg) {
  html.html([attribute.lang("en")], [
    head(),
    html.div([class("flex flex-col h-screen justify-between")], [
      html.body([class("w-screen bg-fuchsia-100")], [
        html.main([], [home_content]),
      ]),
      footer(),
    ]),
  ])
}

pub fn view_page(content: Element(a)) -> Element(a) {
  html.html([attribute.lang("en")], [
    head(),
    html.div([class("flex flex-col min-h-screen h-full justify-between")], [
      body(content),
      footer(),
    ]),
  ])
}

fn body(content: Element(a)) -> Element(a) {
  html.body([class("w-screen bg-fuchsia-100")], [
    html.header([], [
      link.render_link(link.Internal("index.html"), [], [
        html.div([class("flex flex-row p-4 gap-2 items-center")], [
          html.img([
            attribute.src("/images/city.png"),
            class("object-cover h-10 w-10 rounded-full"),
          ]),
          html.h1([class("text-2xl font-mono text-black")], [
            element.text("imcquee"),
          ]),
        ]),
      ]),
    ]),
    html.div([class("w-screen mb-auto")], [
      html.main([class("pb-12")], [content]),
    ]),
  ])
}

fn head() -> Element(a) {
  html.head([], [
    html.meta([attribute.charset("UTF-8")]),
    html.meta([
      attribute.name("description"),
      attribute.content("Isaac McQueen's Personal Website and Blog"),
    ]),
    html.meta([
      attribute.name("title"),
      attribute.content("Isaac McQueen Website"),
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
    html.script(
      [
        attribute.src("/js/copy.js"),
        attribute.attribute("type", "module"),
      ],
      "",
    ),
  ])
}

fn footer() -> Element(a) {
  html.footer([], [
    html.div([class("flex justify-center items-center gap-1")], [
      html.p([class("text-xl")], [element.text("Made with")]),
      link.render_link(
        link.External("https://gleam.run/"),
        [
          class(
            "flex items-center hover:scale-110 transition-transform duration-200",
          ),
        ],
        [
          html.div(
            [class("flex items-center rounded-full bg-purple-300 gap-1 p-1")],
            [
              html.p([class("text-sm")], [element.text("Gleam")]),
              html.img([
                class("rounded-full h-6 w-6"),
                attribute.src("/images/lucy.svg"),
                attribute.alt("lucy"),
              ]),
            ],
          ),
        ],
      ),
      html.p([class("text-xl")], [element.text("and")]),
      link.render_link(
        link.External("https://github.com/lustre-labs/lustre"),
        [
          class(
            "flex items-center hover:scale-110 transition-transform duration-200",
          ),
        ],
        [
          html.div(
            [class("flex items-center rounded-full bg-purple-300 gap-1 p-1")],
            [
              html.p([class("text-sm")], [element.text("Lustre")]),
              html.img([
                class("rounded-full h-6 w-6"),
                attribute.src("/images/lustre.png"),
                attribute.alt("lustre"),
              ]),
            ],
          ),
        ],
      ),
      html.p([class("text-xl")], [element.text("on")]),
      link.render_link(
        link.External("https://github.com/imcquee/imcquee.github.io"),
        [
          class(
            "flex items-center hover:scale-110 transition-transform duration-200",
          ),
        ],
        [
          html.div(
            [class("flex items-center rounded-full bg-purple-300 gap-1 p-1")],
            [
              html.p([class("text-sm")], [element.text("Github")]),
              html.img([
                class("rounded-full h-6 w-6"),
                attribute.src("/images/github.svg"),
                attribute.alt("github"),
              ]),
            ],
          ),
        ],
      ),
    ]),
  ])
}
