import app/utilities/classname.{cn}
import content
import gleam/list
import lustre/attribute.{class}
import lustre/element.{type Element}
import lustre/element/html
import stateless_components/card
import stateless_components/link

type Project(a) {
  Project(title: String, content: List(Element(a)))
}

fn project_to_element(project: Project(a)) {
  card.render_card(False, [class(cn(["p-8"]))], [
    html.h1([class(cn(["text-4xl", "mb-8"]))], [element.text(project.title)]),
    ..project.content
  ])
}

pub fn view() -> Element(a) {
  html.div(
    [
      class(
        cn([
          "grid",
          "lg:grid-cols-3",
          "grid-cols-1",
          "w-screen",
          "gap-12",
          "px-12",
        ]),
      ),
    ],
    [
      Project("NixOS Configuration", [
        html.p([], [
          element.text(
            "My Nix config for NixOS, Darwin, and Linux based environments",
          ),
        ]),
        html.p([class(cn(["mt-4", "text-2xl"]))], [
          element.text("⭐  4"),
        ]),
        link.render_link(
          link.External("https://github.com/imcquee/nix-home"),
          [class(cn(["text-blue-700", "underline"]))],
          [
            element.text("Source"),
          ],
        ),
      ]),
    ]
      |> list.map(fn(card) { project_to_element(card) }),
  )
  |> content.view_page(
    page_info: content.PageInfo(
      title: "Projects Page",
      description: "Page showcasing projects",
      image: "/images/city.webp",
      page_type: "website",
    ),
    show_header: True,
    custom_scripts: [],
  )
}
