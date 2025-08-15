import app/data/posts
import content.{type Page, Bold, Date, Page, Section, Text, Title}
import gleam/list
import lustre/attribute.{attribute, class}
import lustre/element.{type Element}
import lustre/element/html
import pages/post.{type Post}

type BlogCard {
  BlogCard(image: String, description: String, preview_img: String)
}

pub fn view(list: List(Post)) -> Element(a) {
  let posts =
    list.map(posts.all(), fn(post) {
      html.div(
        [
          class(
            "w-full h-full p-4 max-h-36 rounded-md border-2 border-black bg-white
               cursor-pointer select-none
               flex flex-col gap-1
               transition ease-out duration-200
               hover:bg-black/5 hover:shadow-md hover:-translate-y-0.5
               active:translate-y-0
               focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-black focus-visible:ring-offset-2",
          ),
        ],
        [
          html.img([
            attribute.src(post.metadata.preview_img),
            attribute.width(48),
            attribute.height(48),
            attribute.alt(post.metadata.title),
          ]),
          element.text(post.metadata.title),
        ],
      )
    })
  html.div([class("h-screen w-screen px-12 flex gap-4")], posts)
  |> content.view_blog_page()
}
