import content
import gleam/list
import lustre/attribute.{class}
import lustre/element.{type Element}
import lustre/element/html
import lustre/element/svg

type ImageSource {
  SVG(String)
  ASCII(String)
}

type AboutCard {
  AboutCard(image: ImageSource, title: String, subtext: String, href: String)
}

pub fn view() -> Element(a) {
  let about_cards = [
    AboutCard(
      SVG(
        "M12 .297c-6.63 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.6.113.793-.263.793-.583 0-.288-.012-1.237-.017-2.245-3.338.726-4.043-1.416-4.043-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.09-.745.083-.729.083-.729 1.205.085 1.839 1.24 1.839 1.24 1.07 1.835 2.805 1.304 3.493.998.108-.776.418-1.305.76-1.605-2.665-.303-5.466-1.33-5.466-5.93 0-1.312.469-2.384 1.24-3.222-.124-.303-.537-1.523.117-3.176 0 0 1.012-.324 3.312 1.232a11.58 11.58 0 0 1 3.012-.404c1.02.005 2.047.138 3.012.404 2.3-1.556 3.31-1.232 3.31-1.232.655 1.653.242 2.873.118 3.176.773.838 1.238 1.91 1.238 3.222 0 4.61-2.805 5.625-5.478 5.921.43.37.813 1.096.813 2.21 0 1.595-.015 2.877-.015 3.268 0 .323.19.702.799.582C20.565 22.092 24 17.592 24 12c0-6.627-5.373-12-12-12z",
      ),
      "GitHub",
      "@imcquee",
      "https://github.com/imcquee",
    ),
    AboutCard(ASCII("✉️"), "Email", "imcqueendev@gmail.com", "www.google.com"),
  ]

  html.div([], [
    html.div(
      [
        class("flex-row grid px-24 pt-24 grid-cols-1 sm:grid-cols-2"),
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
            class("grid grid-cols-1 w-full sm:grid-cols-2 gap-2"),
          ],
          about_cards
            |> display_about_cards,
        ),
      ],
    ),
  ])
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
              "group block w-full p-4 rounded-md border-2 border-black bg-white
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
              SVG(source) ->
                html.svg(
                  [
                    attribute.attribute("xmlns", "http://www.w3.org/2000/svg"),
                    attribute.attribute("fill", "none"),
                    attribute.attribute("viewBox", "0 0 24 24"),
                    attribute.attribute("height", "24"),
                    attribute.attribute("width", "24"),
                  ],
                  [
                    svg.path([
                      attribute.attribute("d", source),
                      attribute.attribute("fill", "currentColor"),
                    ]),
                  ],
                )
              ASCII(source) -> element.text(source)
            },
            html.p([class("font-mono text-lg")], [element.text(title)]),
            html.p([class("font-mono text-md")], [element.text(subtext)]),
          ],
        ),
      ],
    )
  })
}
