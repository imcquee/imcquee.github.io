import app/utilities/classname.{cn}
import components/clipboard
import content
import gleam/list
import gleam/option.{type Option, None, Some}
import lustre/attribute.{class, classes}
import lustre/element.{type Element}
import lustre/element/html
import stateless_components/card
import stateless_components/link

type ImageSource {
  Image(String)
  Unicode(String)
}

type Action {
  Copy(String)
  Link(link.Link)
}

type AboutCard {
  AboutCard(
    image: ImageSource,
    title: String,
    subtext: Option(String),
    action: Action,
    full_width: Bool,
  )
}

pub fn view() -> Element(a) {
  let about_cards = [
    AboutCard(
      image: Unicode("✏️"),
      title: "Blog",
      subtext: None,
      action: Link(link.Internal("/blog")),
      full_width: True,
    ),
    AboutCard(
      image: Unicode("📃"),
      title: "CV",
      subtext: Some("Download PDF"),
      action: Link(link.External(
        "https://raw.githubusercontent.com/imcquee/Resume/master/cv.pdf",
      )),
      full_width: False,
    ),
    AboutCard(
      image: Unicode("🚧"),
      title: "Projects",
      subtext: None,
      action: Link(link.Internal("/projects")),
      full_width: False,
    ),
    AboutCard(
      image: Image("images/github.svg"),
      title: "GitHub",
      subtext: Some("@imcquee"),
      action: Link(link.External("https://github.com/imcquee")),
      full_width: False,
    ),
    AboutCard(
      image: Unicode("✉️"),
      title: "Email",
      subtext: Some("imcqueendev@gmail.com"),
      action: Copy("imcqueendev@gmail.com"),
      full_width: False,
    ),
  ]

  html.div(
    [
      class(
        cn([
          "flex-row",
          "grid",
          "p-12",
          "lg:p-24",
          "grid-cols-1",
          "gap-8",
          "lg:grid-cols-2",
          "w-screen",
        ]),
      ),
    ],
    [
      html.div(
        [class(cn(["flex", "flex-col", "lg:items-start", "items-center"]))],
        [
          html.img([
            attribute.src("images/city.webp"),
            attribute.alt("city logo"),
            class(cn(["object-cover", "mb-8", "h-48", "w-48", "rounded-full"])),
          ]),
          html.h1([class(cn(["font-mono", "text-4xl", "pb-8", "text-black"]))], [
            element.text("Isaac McQueen"),
          ]),
          html.p([class(cn(["w-full", "text-2xl", "text-black"]))], [
            element.text(
              "Hello 🙋🏾‍♂️ I'm a full-stack software engineer with 6+ years of experience. I use this page to talk about things that excite me. You can also access my cv, contacts, and relevant links.",
            ),
          ]),
        ],
      ),
      html.div(
        [
          class(
            cn(["grid", "w-full", "grid-cols-1", "lg:grid-cols-2", "gap-4"]),
          ),
        ],
        about_cards
          |> display_about_cards,
      ),
    ],
  )
  |> content.view_page(
    page_info: content.PageInfo(
      title: "Isaac McQueen",
      description: "Isaac McQueen's Personal Website and Blog",
      image: "/images/city.webp",
      page_type: "website",
    ),
    show_header: False,
    custom_scripts: [clipboard.get_script()],
  )
}

fn get_card_container(
  action: Action,
  full_width: Bool,
  content: List(Element(a)),
) -> Element(a) {
  let style = "w-full p-4 flex flex-col gap-2 h-full"
  case action {
    Link(link) ->
      link.render_link(
        link,
        [
          classes([#(cn(["col-span-full"]), full_width)]),
        ],
        [
          card.render_card(True, [class(cn([style]))], content),
        ],
      )
    Copy(text) ->
      card.render_card(
        True,
        [
          attribute.role("button"),
          attribute.attribute("copy_button", ""),
          attribute.attribute("data-copy", text),
          classes([#(cn(["col-span-full"]), full_width), #(style, True)]),
        ],
        content,
      )
  }
}

fn display_about_cards(cards: List(AboutCard)) -> List(Element(a)) {
  list.map(cards, fn(card) {
    let AboutCard(image_source, title, subtext, action, full_width) = card
    get_card_container(action, full_width, [
      html.div([class(cn(["flex", "flex-row", "gap-2", "items-center"]))], [
        case image_source {
          Image(source) ->
            html.img([
              attribute.src(source),
              attribute.width(28),
              attribute.height(28),
              attribute.alt(title),
            ])
          Unicode(source) ->
            html.p([class(cn(["text-xl", "font-light"]))], [
              element.text(source),
            ])
        },
        html.p([class(cn(["text-2xl", "truncate"]))], [element.text(title)]),
      ]),
      case subtext {
        None -> element.none()
        Some(text) ->
          html.p([class(cn(["font-mono", "text-lg", "truncate"]))], [
            element.text(text),
          ])
      },
    ])
  })
}
