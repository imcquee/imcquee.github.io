import app/page/post.{type Post}
import app/utilities/date
import content
import gleam/list
import lustre/attribute.{class}
import lustre/element.{type Element}
import lustre/element/html
import stateless_components/card
import stateless_components/link
import stateless_components/tag

pub fn view(list: List(Post)) -> Element(a) {
  let sorted_list =
    list
    |> list.sort(fn(post1, post2) {
      date.compare_post_dates(post1.metadata.date, post2.metadata.date)
    })
  html.div(
    [class("w-screen md:px-12 px-4 flex flex-col gap-4")],
    list.map(sorted_list, fn(post) {
      link.render_link(link.Internal("./blog/" <> post.metadata.slug), [], [
        card.render_card(
          True,
          [
            class(
              "flex md:flex-row flex-col gap-1 items-center w-full py-2 px-4",
            ),
          ],
          [
            html.img([
              class("object-contain md:h-36 md:w-36 h-48 w-48 rounded-md"),
              attribute.src(post.metadata.preview_img),
              attribute.width(48),
              attribute.height(48),
              attribute.alt(post.metadata.title),
            ]),
            html.div([class("flex flex-col p-4 gap-2")], [
              html.h1([class("md:text-3xl text-xl font-bold")], [
                element.text(post.metadata.title),
              ]),
              tag.render_tags(post.metadata.tags, [class("text-sm")]),
              html.h1([class("italic md:text-lg")], [
                element.text(post.metadata.date |> date.pretty_print()),
              ]),
              html.p([class("italic md:text-lg")], [
                element.text(post.metadata.description),
              ]),
            ]),
          ],
        ),
      ])
    }),
  )
  |> content.view_page(content.PageInfo(
    title: "Isaac McQueen Blog",
    description: "Blog page where you can browse my blog posts",
    image: "/images/city.png",
    page_type: "website",
  ))
}
