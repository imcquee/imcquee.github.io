import app/utilities/classname.{cn}
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

pub fn view_page(
  content content: Element(a),
  page_info page: PageInfo,
  show_header show_header: Bool,
  custom_scripts custom_scripts: List(Element(a)),
) -> Element(a) {
  html.html([attribute.lang("en")], [
    head(page, custom_scripts),
    html.div(
      [
        class(
          cn(["flex", "flex-col", "min-h-screen", "h-full", "justify-between"]),
        ),
      ],
      [
        body(content, show_header),
        footer(),
      ],
    ),
  ])
}

fn head(page: PageInfo, custom_scripts: List(Element(a))) -> Element(a) {
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
    ..custom_scripts
  ])
}

fn body(content: Element(a), show_header: Bool) -> Element(a) {
  let header = case show_header {
    True ->
      html.header([], [
        link.render_link(
          link.Internal("/index.html"),
          [class(cn(["inline-flex", "p-4", "gap-2", "items-center"]))],
          [
            html.img([
              attribute.src("/images/city.webp"),
              attribute.alt("city logo"),
              class(cn(["object-cover", "h-10", "w-10", "rounded-full"])),
            ]),
            html.h1([class(cn(["text-2xl", "font-mono", "text-black"]))], [
              element.text("imcquee"),
            ]),
          ],
        ),
      ])
    False -> element.none()
  }

  html.body([class(cn(["w-screen", "bg-fuchsia-100"]))], [
    header,
    html.div([class(cn(["w-screen", "mb-auto"]))], [
      html.main([class(cn(["pb-12"]))], [content]),
    ]),
  ])
}

fn footer() -> Element(a) {
  html.footer([], [
    html.div([class(cn(["flex", "flex-col", "items-center"]))], [
      html.div(
        [class(cn(["flex", "justify-center", "items-center", "gap-1"]))],
        [
          html.p([class(cn(["md:text-lg", "text-xs"]))], [
            element.text("Made with"),
          ]),
          render_footer_button(FooterButton(
            name: "Gleam",
            src: "https://gleam.run/",
            icon: "/images/lucy.svg",
          )),
          html.p([class(cn(["md:text-lg", "text-xs]"]))], [element.text("and")]),
          render_footer_button(FooterButton(
            name: "Lustre",
            src: "https://github.com/lustre-labs/lustre",
            icon: "/images/lustre.png",
          )),
          html.p([class(cn(["md:text-lg", "text-xs"]))], [element.text("on")]),
          render_footer_button(FooterButton(
            name: "Github",
            src: "https://github.com/imcquee/imcquee.github.io",
            icon: "/images/github.svg",
          )),
        ],
      ),
      html.p([class(cn(["text-xs", "text-center"]))], [
        element.text(
          "All product names, logos, and brands are property of their respective owners",
        ),
      ]),
    ]),
  ])
}

fn render_footer_button(button: FooterButton) {
  link.render_link(
    link.External(button.src),
    [
      class(
        cn([
          "flex",
          "items-center",
          "hover:scale-110",
          "transition-transform",
          "duration-200",
        ]),
      ),
    ],
    [
      html.div(
        [class(cn(["flex", "items-center", "rounded-full", "gap-1", "p-1"]))],
        [
          html.p([class(cn(["md:text-lg", "text-xs"]))], [
            element.text(button.name),
          ]),
          html.img([
            class(cn(["rounded-full", "h-6", "w-6"])),
            attribute.src(button.icon),
            attribute.alt(button.name <> "logo"),
          ]),
        ],
      ),
    ],
  )
}
