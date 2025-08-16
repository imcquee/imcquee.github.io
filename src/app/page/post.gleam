import content
import gleam/result
import lustre/attribute.{class}
import lustre/element.{type Element}
import lustre/element/html
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
  use metadata <- result.try(djot.metadata(path) |> result.replace_error(Nil))
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

pub fn view(post: Post) -> Element(Nil) {
  html.div([class("flex flex-col items-center px-12 gap-2")], [
    html.div([class("p-4 rounded-md border-2 border-black bg-white w-3/4")], [
      html.h1([class("text-3xl")], [element.text(post.metadata.title)]),
    ]),
    html.div([class("p-4 rounded-md border-2 border-black bg-white w-3/4")], [
      html.h1([], [element.text("August 14, 2025")]),
    ]),
    html.div(
      [class("p-4 rounded-md border-2 border-black bg-white w-3/4")],
      post.content,
    ),
  ])
  |> content.view_page()
}
