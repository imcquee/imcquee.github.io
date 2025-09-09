import lustre/attribute.{class}
import lustre/element.{type Element}
import lustre/element/html
import stateless_components/link

pub type PageInfo {
  PageInfo(title: String, description: String, image: String, page_type: String)
}

type FooterButton {
  FooterButton(name: String, src: String, icon: String)
}

pub fn view_home(home_content: Element(msg), page: PageInfo) -> Element(msg) {
  html.html([attribute.lang("en")], [
    head(page),
    html.div([class("flex flex-col h-screen justify-between")], [
      html.body([class("bg-fuchsia-100")], [
        html.main([], [home_content]),
      ]),
      footer(),
    ]),
  ])
}

pub fn view_page(content: Element(a), page: PageInfo) -> Element(a) {
  html.html([attribute.lang("en")], [
    head(page),
    html.div([class("flex flex-col min-h-screen h-full justify-between")], [
      body(content),
      footer(),
    ]),
  ])
}

fn head(page: PageInfo) -> Element(a) {
  html.head([], [
    html.title([], page.title),
    html.meta([attribute.charset("UTF-8")]),
    html.meta([
      attribute.name("description"),
      attribute.content(page.description),
    ]),
    html.meta([
      attribute.name("viewport"),
      attribute.content("width=device-width, initial-scale=1.0"),
    ]),
    html.meta([
      attribute.attribute("property", "og:title"),
      attribute.content(page.title),
    ]),
    html.meta([
      attribute.attribute("property", "og:description"),
      attribute.content(page.description),
    ]),
    html.meta([
      attribute.attribute("property", "og:image"),
      attribute.content(page.image),
    ]),
    html.meta([
      attribute.attribute("property", "og:type"),
      attribute.content(page.page_type),
    ]),
    html.meta([
      attribute.attribute("property", "twitter:title"),
      attribute.content(page.title),
    ]),
    html.meta([
      attribute.attribute("property", "twitter:description"),
      attribute.content(page.description),
    ]),
    html.meta([
      attribute.attribute("property", "twitter:image"),
      attribute.content(page.image),
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
    html.script(
      [
        attribute.attribute("type", "module"),
      ],
      "import{main}from'/js/clipboard.js';document.addEventListener(\"DOMContentLoaded\",()=>{main({})});",
    ),
    html.script(
      [
        attribute.attribute("type", "module"),
        attribute.src("/js/mermaid.tiny.js")
      ],
      ""
    )
  ])
}

fn body(content: Element(a)) -> Element(a) {
  html.body([class("w-screen bg-fuchsia-100")], [
    html.header([], [
      link.render_link(
        link.Internal("index.html"),
        [class("inline-flex p-4 gap-2 items-center")],
        [
          html.img([
            attribute.src("/images/city.png"),
            attribute.alt("city logo"),
            class("object-cover h-10 w-10 rounded-full"),
          ]),
          html.h1([class("text-2xl font-mono text-black")], [
            element.text("imcquee"),
          ]),
        ],
      ),
    ]),
    html.div([class("w-screen mb-auto")], [
      html.main([class("pb-12")], [content]),
    ]),
  ])
}

fn footer() -> Element(a) {
  html.footer([], [
    html.div([class("flex justify-center items-center gap-1")], [
      html.p([class("md:text-lg text-xs")], [element.text("Made with")]),
      render_footer_button(FooterButton(
        name: "Gleam",
        src: "https://gleam.run/",
        icon: "/images/lucy.svg",
      )),
      html.p([class("md:text-lg text-xs")], [element.text("and")]),
      render_footer_button(FooterButton(
        name: "Lustre",
        src: "https://github.com/lustre-labs/lustre",
        icon: "/images/lustre.png",
      )),
      html.p([class("md:text-lg text-xs")], [element.text("on")]),
      render_footer_button(FooterButton(
        name: "Github",
        src: "https://github.com/imcquee/imcquee.github.io",
        icon: "/images/github.svg",
      )),
    ]),
  ])
}

fn render_footer_button(button: FooterButton) {
  link.render_link(
    link.External(button.src),
    [
      class(
        "flex items-center hover:scale-110 transition-transform duration-200",
      ),
    ],
    [
      html.div([class("flex items-center rounded-full gap-1 p-1")], [
        html.p([class("md:text-lg text-xs")], [element.text(button.name)]),
        html.img([
          class("rounded-full h-6 w-6"),
          attribute.src(button.icon),
          attribute.alt(button.name <> "logo"),
        ]),
      ]),
    ],
  )
}
