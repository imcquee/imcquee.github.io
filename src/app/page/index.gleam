import content
import gleam/list
import gleam/option.{type Option, None, Some}
import lustre/attribute.{class, classes}
import lustre/element.{type Element}
import lustre/element/html

type ImageSource {
  Image(String)
  ASCII(String)
}

type Link {
  Internal(String)
  External(String)
}

type AboutCard {
  AboutCard(
    image: ImageSource,
    title: String,
    subtext: Option(String),
    href: Link,
    full_width: Bool,
  )
}

pub fn view() -> Element(a) {
  let about_cards = [
    AboutCard(ASCII("🕮"), "Blog", None, Internal("./blog"), True),
    AboutCard(
      ASCII("📃"),
      "CV",
      None,
      External("https://raw.githubusercontent.com/imcquee/Resume/master/cv.pdf"),
      False,
    ),
    AboutCard(
      ASCII("🔧"),
      "Tools",
      None,
      Internal("https://raw.githubusercontent.com/imcquee/Resume/master/cv.pdf"),
      False,
    ),
    AboutCard(
      Image("images/github.svg"),
      "GitHub",
      Some("@imcquee"),
      External("https://github.com/imcquee"),
      False,
    ),
    AboutCard(
      ASCII("✉️"),
      "Email",
      Some("imcqueendev@gmail.com"),
      External("mailto:imcqueendev@gmail.com"),
      False,
    ),
  ]

  html.div(
    [
      class(
        "flex-row grid px-24 pt-24 grid-cols-1 gap-4 sm:grid-cols-2 w-screen",
      ),
    ],
    [
      html.div([class("flex-row")], [
        html.img([
          attribute.src("images/city.png"),
          class("object-cover mb-8 h-36 w-36 rounded-full"),
        ]),
        html.h1([class("font-mono text-4xl pb-8 text-black")], [
          element.text("Isaac McQueen"),
        ]),
        html.p([class("max-w-lg text-md font-mono text-black")], [
          element.text(
            "Hello 🙋🏾‍♂️ I'm a full-stack software engineer with 6+ years of experience. I use this page to talk about things that excite me. You can also access my cv, contacts, and relevant links.",
          ),
        ]),
      ]),
      html.div(
        [
          class("grid w-full grid-cols-1 sm:grid-cols-2 gap-2"),
        ],
        about_cards
          |> display_about_cards,
      ),
    ],
  )
  |> content.view_home()
}

fn display_about_cards(cards: List(AboutCard)) -> List(Element(a)) {
  list.map(cards, fn(card) {
    let AboutCard(image_source, title, subtext, href, full_width) = card
    let style =
      "w-full h-full p-4 rounded-md border-2 border-black bg-white
               cursor-pointer select-none
               flex flex-col gap-1
               transition ease-out duration-200
               hover:bg-black/5 hover:shadow-md hover:-translate-y-0.5
               active:translate-y-0
               focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-black focus-visible:ring-offset-2"
    let link_attributes = case href {
      External(src) -> [
        attribute.rel("noopener noreferrer"),
        attribute.target("_blank"),
        attribute.href(src),
        classes([#("col-span-full", full_width), #(style, True)]),
      ]
      Internal(src) -> [
        attribute.href(src),
        classes([#("col-span-full", full_width), #(style, True)]),
      ]
    }

    html.a(link_attributes, [
      case image_source {
        Image(source) ->
          html.img([
            attribute.src(source),
            attribute.width(24),
            attribute.height(24),
            attribute.alt(title),
          ])
        ASCII(source) -> element.text(source)
      },
      html.p([class("font-mono text-lg")], [element.text(title)]),
      case subtext {
        None -> element.none()
        Some(text) ->
          html.p([class("font-mono text-md truncate")], [
            element.text(text),
          ])
      },
    ])
  })
}
