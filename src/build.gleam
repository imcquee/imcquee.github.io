import app/data/posts
import app/page/blog
import app/page/index
import app/page/post
import app/page/projects
import app/utilities/date
import gleam/dict
import gleam/io
import gleam/list
import lustre/ssg

const out_dir = "./priv"

const static_dir = "./static"

pub fn main() {
  let posts =
    list.map(posts.all(), fn(post) { #(post.metadata.slug, post) })
    |> dict.from_list()

  let build =
    ssg.new(out_dir)
    |> ssg.add_static_route("/", index.view())
    |> ssg.add_static_route("/blog", blog.view(posts.all()))
    |> ssg.add_static_route("/projects", projects.view())
    |> ssg.add_dynamic_route("/blog", posts, post.view)
    |> ssg.add_static_dir(static_dir)
    |> ssg.build

  case build {
    Ok(_) -> io.println("Build succeeded!")
    Error(e) -> {
      echo e
      io.println("Build failed!")
    }
  }
}
