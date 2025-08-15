import content.{type Page, Bold, Date, Page, Section, Text, Title}
import gleam/list
import gleam/result
import lustre/attribute.{class}
import lustre/element.{type Element}
import lustre/ssg/djot
import simplifile
import tom

pub type Metadata {
  Metadata(
    slug: String,
    title: String,
    description: String,
    preview_img: String,
  )
}

pub type Post {
  Post(metadata: Metadata, content: List(Element(Nil)))
}

pub fn parse(path path: String) -> Post {
  let post = {
    use file <- result.try(simplifile.read(path) |> result.replace_error(Nil))
    let content = djot.render(file, djot.default_renderer())
    use metadata <- result.try(
      parse_metadata(file) |> result.replace_error(Nil),
    )
    Ok(Post(metadata:, content:))
  }
  case post {
    Ok(post) -> post
    Error(_) -> {
      let error_message = "could not parse content from file: " <> path
      panic as error_message
    }
  }
}

fn parse_metadata(path: String) -> Result(Metadata, Nil) {
  echo path
  use metadata <- result.try(djot.metadata(path) |> result.replace_error(Nil))
  echo metadata
  use slug <- result.try(
    tom.get_string(metadata, ["slug"])
    |> result.replace_error(Nil),
  )
  use title <- result.try(
    tom.get_string(metadata, ["title"])
    |> result.replace_error(Nil),
  )
  use description <- result.try(
    tom.get_string(metadata, ["description"])
    |> result.replace_error(Nil),
  )
  use preview_img <- result.try(
    tom.get_string(metadata, ["preview_img"])
    |> result.replace_error(Nil),
  )

  Ok(Metadata(slug:, title:, description:, preview_img:))
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
