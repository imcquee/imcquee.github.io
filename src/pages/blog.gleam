import content
import gleam/list
import lustre/attribute.{class}
import lustre/element.{type Element}
import lustre/element/html
import pages/post.{type Post}

pub fn view(list: List(Post)) -> Element(a) {
  let posts =
    list.map(list, fn(post) {
      html.a([attribute.href("./blog/" <> post.metadata.slug)], [
        html.div(
          [
            class(
              "flex p-4 max-h-36 rounded-md border-2 border-black bg-white
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
        ),
      ])
    })
  html.div([class("h-screen w-screen px-12 flex gap-4")], posts)
  |> content.view_blog_page()
}
