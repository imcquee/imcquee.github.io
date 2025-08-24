import app/page/post.{type Post}
import content
import gleam/list
import lustre/attribute.{class}
import lustre/element.{type Element}
import lustre/element/html

pub fn view(list: List(Post)) -> Element(a) {
  html.div(
    [class("h-screen w-screen px-12 flex flex-col gap-4")],
    list.map(list, fn(post) {
      html.a([attribute.href("./blog/" <> post.metadata.slug)], [
        html.div([class("w-full")], [
          html.div(
            [
              class(
                "flex md:flex-row flex-col w-full p-8 rounded-md border-2 border-black bg-white
                 cursor-pointer select-none flex flex-col gap-1 items-center transition ease-out
                 duration-200 hover:bg-black/5 hover:shadow-md hover:-translate-y-0.5 active:translate-y-0
                 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-black focus-visible:ring-offset-2",
              ),
            ],
            [
              html.img([
                class("object-cover md:h-36 md:w-36 h-48 w-48 rounded-md"),
                attribute.src(post.metadata.preview_img),
                attribute.width(48),
                attribute.height(48),
                attribute.alt(post.metadata.title),
              ]),
              html.div([class("flex flex-col p-4 gap-2")], [
                html.h1([class("md:text-3xl text-xl font-bold")], [
                  element.text(post.metadata.title),
                ]),
                html.h1([class("italic md:text-lg")], [
                  element.text(post.metadata.date),
                ]),
                html.p([class("italic md:text-lg")], [
                  element.text(post.metadata.description),
                ]),
              ]),
            ],
          ),
        ]),
      ])
    }),
  )
  |> content.view_page()
}
