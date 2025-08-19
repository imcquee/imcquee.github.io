import app/stateless_components/tag.{type TagInfo}
import app/utilities/djot_renderer
import content
import gleam/list
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
    tags: List(TagInfo),
  )
}

pub type Post {
  Post(metadata: Metadata, content: List(Element(Nil)))
}

pub fn parse(path path: String) -> Post {
  let post = {
    use file <- result.try(simplifile.read(path) |> result.replace_error(Nil))

    let content = djot.render(file, djot_renderer.custom_renderer())
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
  use list_of_tags <- result.try(
    tom.get_string(metadata, ["tags"])
    |> result.replace_error(Nil),
  )
  let tags = list_of_tags |> tag.parse_tags("|")

  Ok(Metadata(slug:, title:, description:, preview_img:, date:, tags:))
}

fn render_tags(tags: List(TagInfo)) -> Element(a) {
  let tag_list =
    list.map(tags, fn(tag) {
      let #(name, color) = tag.to_string(tag.name, tag.color)

      html.div(
        [
          class(color <> " px-4 border-2 border-black rounded-md"),
        ],
        [
          element.text(name),
        ],
      )
    })

  html.div([class("flex flex-row gap-3")], tag_list)
}

pub fn view(post: Post) -> Element(Nil) {
  html.div([class("flex flex-col items-center lg:px-12 lg:gap-2")], [
    html.a(
      [
        class(
          "lg:fixed lg:left-4 ml-2 self-start p-4 mb-4 rounded-md border-2 border-black bg-white lg:h-18 flex items-center                hover:bg-black/5 hover:shadow-md hover:-translate-y-0.5
           active:translate-y-0
           focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-black focus-visible:ring-offset-2",
        ),
        attribute.href("/blog"),
      ],
      [
        html.h1([class("font-bold text-xl")], [element.text("<- Blog")]),
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
          "flex flex-row gap-3 items-center lg:p-4 py-1 px-2 lg:rounded-md lg:border-2 lg:border-black lg:bg-white lg:w-3/4 w-full",
        ),
      ],
      [
        html.h1([class("italic")], [element.text(post.metadata.date)]),
        render_tags(post.metadata.tags),
      ],
    ),
    html.div(
      [
        class(
          "flex flex-col lg:p-4 py-1 px-2 lg:rounded-md lg:border-2 lg:border-black lg:bg-white lg:w-3/4 w-full",
        ),
      ],
      post.content,
    ),
  ])
  |> content.view_page()
}
