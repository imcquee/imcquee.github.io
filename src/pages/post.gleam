import content.{
  type Page, Bold, Code, Heading, Page, Section, Snippet, Subheading, Text,
  Title,
}
import gleam/list
import gleam/result
import lustre/attribute.{class}
import lustre/element.{type Element}
import lustre/ui
import simplifile

pub type Post {
  Post(
    slug: String,
    title: String,
    description: String,
    author: String,
    date: String,
    content: String,
  )
}

pub fn fetch() {
  todo
  //   use post_files <- result.try(simplifile.read_directory("src/pages/posts/"))

  //   // use posts <- result.try(
  //   //   post_files
  //   //   |> list.map(extract_post)
  //   //   |> result.all(),
  //   // )

  //   Ok(
  //     posts
  //     |> list.filter(validate)
  //     |> list.sort(most_recent),
  //   )
}

pub fn view(post: Post) -> Element(a) {
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
