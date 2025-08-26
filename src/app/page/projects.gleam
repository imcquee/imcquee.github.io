import content
import gleam/list
import lustre/attribute.{class}
import lustre/element.{type Element}
import lustre/element/html
import stateless_components/link

type Card(a) {
  Card(title: String, content: List(Element(a)))
}

fn card_to_element(card: Card(a)) {
  html.div([class("border-2 border-black rounded-md bg-white p-8")], [
    html.h1([class("text-4xl mb-8")], [element.text(card.title)]),
    ..card.content
  ])
}

pub fn view() -> Element(a) {
  html.div(
    [class("grid grid-cols-3 w-screen gap-12 px-12")],
    [
      Card("NixOS Configuration", [
        html.p([], [
          element.text(
            "My Nix config for NixOS, Darwin, and Linux based environments",
          ),
        ]),
        html.p([class("mt-4 text-2xl")], [
          element.text("⭐  4"),
        ]),
        link.render_link(
          link.External("https://github.com/imcquee/nix-home"),
          [],
          [
            element.text("Source"),
          ],
        ),
      ]),
    ]
      |> list.map(fn(card) { card_to_element(card) }),
  )
  |> content.view_page(content.PageInfo(
    title: "Projects Page",
    description: "Page showcasing projects",
    image: "/images/city.png",
    page_type: "website",
  ))
}
