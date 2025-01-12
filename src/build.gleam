import gleam/dict
import gleam/io
import gleam/list
import lustre/ssg
import pages/index

pub fn main() {
  let posts =
    dict.from_list({
      use post <- list.map(posts.all())
      #(post.id, post)
    })

  let build =
    ssg.new("./priv")
    |> ssg.add_static_route("/", index.view())
    |> ssg.build

  case build {
    Ok(_) -> io.println("Build succeeded!")
    Error(e) -> {
      io.debug(e)
      io.println("Build failed!")
    }
  }
}
