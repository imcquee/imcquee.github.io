import content.{
  type Page, Bold, Code, Heading, Page, Section, Snippet, Subheading, Text,
  Title,
}
import lustre/attribute.{class}
import lustre/element.{type Element}
import lustre/ui

pub fn view() -> Element(a) {
  Page(title: "Home", content: [
    Title("First Post"),
    Subheading("10-12-2024"),
    Section([
      Text(
        "Fonts are essential in web design as they give personality to your website, improve readability, and evoke certain emotions.
Although Tailwind CSS provides many default fonts, there are times when you may want a more unique option.
Custom fonts can assist you in achieving that special appearance.",
      ),
    ]),
  ])
  |> content.view_page()
}
