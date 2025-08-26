import app/utilities/djot_renderer
import content
import lustre/attribute.{class}
import lustre/element.{type Element}
import lustre/element/html
import lustre/ssg/djot
import simplifile
import stateless_components/link
import stateless_components/tag.{type TagInfo, render_tags}
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
  let assert Ok(file) = simplifile.read(path)
  let content = djot.render(file, djot_renderer.custom_renderer())
  let assert Ok(metadata) = parse_metadata(file)
  Post(metadata:, content:)
}

fn parse_metadata(path: String) -> Result(Metadata, Nil) {
  let assert Ok(metadata) = djot.metadata(path)
  let assert Ok(slug) = tom.get_string(metadata, ["slug"])
  let assert Ok(title) = tom.get_string(metadata, ["title"])
  let assert Ok(description) = tom.get_string(metadata, ["description"])
  let assert Ok(preview_img) = tom.get_string(metadata, ["preview_img"])
  let assert Ok(date) = tom.get_string(metadata, ["date"])
  let assert Ok(list_of_tags) = tom.get_string(metadata, ["tags"])
  let tags = list_of_tags |> tag.parse_tags("|")

  Ok(Metadata(slug:, title:, description:, preview_img:, date:, tags:))
}

pub fn view(post: Post) -> Element(Nil) {
  html.div([class("flex flex-col items-center lg:px-12 lg:gap-2")], [
    link.render_link(
      link.Internal("/blog"),
      [
        class(
          "lg:fixed lg:left-4 ml-2 self-start p-4 mb-4 rounded-md border-2 border-black bg-white lg:h-18 flex items-center
           hover:bg-black/5 hover:shadow-md hover:-translate-y-0.5 active:translate-y-0
           focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-black focus-visible:ring-offset-2",
        ),
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
        html.h1([class("md:text-3xl text-xl")], [
          element.text(post.metadata.title),
        ]),
      ],
    ),
    html.div(
      [
        class(
          "flex flex-col md:flex-row gap-3 md:items-center lg:p-4 py-1 px-2 lg:rounded-md lg:border-2 lg:border-black lg:bg-white lg:w-3/4 w-full",
        ),
      ],
      [
        html.h1([class("italic")], [element.text(post.metadata.date)]),
        render_tags(post.metadata.tags, [class("text-xs md:text-base")]),
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
  |> content.view_page(content.PageInfo(
    title: post.metadata.title,
    description: post.metadata.description,
    image: post.metadata.preview_img,
    page_type: "article",
  ))
}
