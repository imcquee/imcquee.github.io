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
    date: String,
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
  use date <- result.try(
    tom.get_string(metadata, ["date"])
    |> result.replace_error(Nil),
  )

  Ok(Metadata(slug:, title:, description:, preview_img:, date:))
}

pub fn view(post: Post) -> Element(Nil) {
  html.div([class("flex flex-col items-center lg:px-12 lg:gap-2")], [
    html.a(
      [
        class(
          "lg:fixed lg:left-4 ml-2 self-start p-4 mb-4 rounded-md border-2 border-black bg-white lg:h-18 flex items-center",
        ),
        attribute.href("/blog"),
      ],
      [
        html.h1([class("font-bold text-xl")], [element.text("Back to Blog")]),
      ],
    ),
    html.div(
      [
        class(
          "lg:p-4 py-1 px-2 lg:rounded-md lg:border-2 lg:border-black lg:bg-white lg:w-3/4 w-full",
        ),
      ],
      [
        html.h1([class("text-3xl")], [element.text(post.metadata.title)]),
      ],
    ),
    html.div(
      [
        class(
          "lg:p-4 py-1 px-2 lg:rounded-md lg:border-2 lg:border-black lg:bg-white lg:w-3/4 w-full",
        ),
      ],
      [
        html.h1([class("italic")], [element.text(post.metadata.date)]),
      ],
    ),
    html.div(
      [
        class(
          "lg:p-4 py-1 px-2 lg:rounded-md lg:border-2 lg:border-black lg:bg-white lg:w-3/4 w-full",
        ),
      ],
      post.content,
    ),
  ])
  |> content.view_page()
}
