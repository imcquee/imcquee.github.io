import gleam/dict
import gleam/io
import gleam/list
import lustre/ssg
import pages/home
import pages/post
import pages/presentation

pub fn main() {
  // let posts =
  //   dict.from_list({
  //     use post <- list.map(posts.all())
  //     #(post.id, post)
  //   })

  let assert Ok(_) =
    ssg.new("./priv")
    |> ssg.add_static_route("/", home.view())
    |> ssg.add_static_route("/presentation", presentation.view())
    // |> ssg.add_dynamic_route("/posts", posts, post.view)
    |> ssg.add_static_dir("./static")
    |> ssg.build
}
