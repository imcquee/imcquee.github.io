import content.{type Page, Bold, Date, Page, Section, Text, Title}
import gleam/list
import gleam/result
import lustre/attribute.{class}
import lustre/element.{type Element}
import lustre/ssg/djot
import simplifile

pub type Post {
  Post(slug: String, content: List(Element(Nil)))
}

pub fn parse(from filepath: String) -> Post {
  let post = {
    use file <- result.try(
      simplifile.read(filepath) |> result.replace_error(Nil),
    )
    let content = djot.render(file, djot.default_renderer())
    let slug = "touch"

    Ok(Post(slug:, content:))
  }
  case post {
    Ok(post) -> post
    Error(_) -> {
      let error_message = "could not parse content from file: " <> filepath
      panic as error_message
    }
  }
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
    Date("August 3, 2025"),
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
