import content
import gleam/list
import gleam/option.{type Option, None, Some}
import lustre/attribute.{class}
import lustre/element.{type Element}
import lustre/element/html

type ImageSource {
  Image(String)
  ASCII(String)
}

type AboutCard {
  AboutCard(
    image: ImageSource,
    title: String,
    subtext: Option(String),
    href: String,
  )
}

pub fn view() -> Element(a) {
  let about_cards = [
    AboutCard(
      Image("images/github.svg"),
      "GitHub",
      Some("@imcquee"),
      "https://github.com/imcquee",
    ),
    AboutCard(
      ASCII("✉️"),
      "Email",
      Some("imcqueendev@gmail.com"),
      "mailto:imcqueendev@gmail.com",
    ),
    AboutCard(
      ASCII("📃"),
      "CV",
      None,
      "https://raw.githubusercontent.com/imcquee/Resume/master/cv.pdf",
    ),
    AboutCard(
      ASCII("🔧"),
      "Tools",
      None,
      "https://raw.githubusercontent.com/imcquee/Resume/master/cv.pdf",
    ),
  ]

  html.div(
    [
      class(
        "w-screen h-screen flex-row grid px-12 pt-24 grid-cols-1 sm:grid-cols-2",
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
          class("grid grid-cols-3 w-full sm:grid-cols-2 py-12 gap-2"),
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
    let AboutCard(image_source, title, subtext, href) = card
    html.a(
      [
        attribute.rel("noopener noreferrer"),
        attribute.target("_blank"),
        attribute.href(href),
      ],
      [
        html.div(
          [
            class(
              "w-full h-full p-4 rounded-md border-2 border-black bg-white
               cursor-pointer select-none
               flex flex-col gap-1
               transition ease-out duration-200
               hover:bg-black/5 hover:shadow-md hover:-translate-y-0.5
               active:translate-y-0
               focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-black focus-visible:ring-offset-2",
            ),
          ],
          [
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
          ],
        ),
      ],
    )
  })
}
