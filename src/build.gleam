import app/page/blog
import app/page/index
import app/page/post.{type Post}
import app/page/projects
import esgleam
import gleam/dict
import gleam/io
import gleam/list
import lustre/ssg
import simplifile

pub fn main() {
  let static_dir = "./static"
  let out_dir = "./priv"
  let posts =
    get_posts()
    |> list.map(fn(post) { #(post.metadata.slug, post) })
    |> dict.from_list()

  let build =
    ssg.new(out_dir)
    |> ssg.add_static_route("/", index.view())
    |> ssg.add_static_route("/blog", get_posts() |> blog.view())
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
  get_components()
}

fn get_components() {
  let assert Ok(paths) = simplifile.read_directory("./src/components")
  use file <- list.map(paths)
  let es_build =
    esgleam.new("./static/js")
    |> esgleam.entry("components/" <> file)
    |> esgleam.bundle

  case es_build {
    Ok(_) -> io.println("Esbuild succeeded!")
    Error(e) -> {
      echo e
      io.println("Esbuild failed!")
    }
  }
}

fn get_posts() -> List(Post) {
  let posts_dir = "./posts"
  let assert Ok(paths) = simplifile.read_directory(posts_dir)
  use file <- list.map(paths)
  post.parse(path: posts_dir <> "/" <> file)
}
