import app/page/post.{type Post}
import app/utilities/date
import content
import gleam/list
import gleam/option.{type Option, None, Some}
import lustre/attribute.{class}
import lustre/element.{type Element}
import lustre/element/html
import stateless_components/card
import stateless_components/link
import stateless_components/tag

pub type PostList {
  PostList(tag: Option(tag.TagInfo), list: List(Post))
}

pub fn view(posts: PostList) -> Element(a) {
  let sorted_list =
    posts.list
    |> list.sort(fn(post1, post2) {
      date.compare_post_dates(post1.metadata.date, post2.metadata.date)
    })

  let filtered_list = case posts.tag {
    None -> sorted_list
    Some(tag) ->
      list.filter(sorted_list, fn(post) {
        list.contains(post.metadata.tags, tag)
      })
  }

  let all_tags =
    list.flat_map(filtered_list, fn(post) { post.metadata.tags })
    |> list.unique()

  let filter = case posts.tag {
    None ->
      html.div([class("flex flex-row gap-2")], [
        tag.render_tags(all_tags, [], True),
      ])
    Some(tag) ->
      html.div([class("flex flex-row gap-2 items-center")], [
        tag.render_tags([tag], [], False),
        link.render_link(
          link.Internal("/blog"),
          [class("text-blue-700 underline")],
          [element.text("Clear Filter")],
        ),
      ])
  }

  let blog_posts =
    list.map(filtered_list, fn(post) {
      link.render_link(link.Internal("/blog/" <> post.metadata.slug), [], [
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
              tag.render_tags(post.metadata.tags, [class("text-sm")], False),
              html.h1([class("italic md:text-lg")], [
                element.text(post.metadata.date |> date.pretty_print()),
              ]),
              html.p([class("md:text-lg")], [
                element.text(post.metadata.description),
              ]),
            ]),
          ],
        ),
      ])
    })

  html.div([class("w-screen md:px-12 px-4 flex flex-col gap-4")], [
    filter,
    ..blog_posts
  ])
  |> content.view_page(
    content.PageInfo(
      title: "Isaac McQueen Blog",
      description: "Blog page where you can browse my blog posts",
      image: "/images/city.png",
      page_type: "website",
    ),
    True,
  )
}
