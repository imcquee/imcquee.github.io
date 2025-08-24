import content
import gleam/list
import lustre/attribute.{class}
import lustre/element.{type Element}
import lustre/element/html

type Card(a) {
  Card(title: String, content: List(Element(a)))
}

fn card_to_element(card: Card(a)) {
  html.div([class("h-72 border-2 border-black rounded-md bg-white p-8")], [
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
        html.a(
          [
            attribute.rel("noopener noreferrer"),
            attribute.target("_blank"),
            attribute.href("https://github.com/imcquee/nix-home"),
            class("flex flex-row gap-2 text-sky-400 underline "),
          ],
          [
            html.img([attribute.src("/images/github.svg")]),
            element.text("Source"),
          ],
        ),
      ]),
    ]
      |> list.map(fn(card) { card_to_element(card) }),
  )
  |> content.view_page()
}
