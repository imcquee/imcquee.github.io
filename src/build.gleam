import app/page/blog
import app/page/index
import app/page/post.{type Post}
import app/page/projects
import envoy
import esgleam
import gleam/dict
import gleam/io
import gleam/list
import gleam/option.{None, Some}
import lustre/ssg
import simplifile
import stateless_components/tag

pub fn main() {
  let assert Ok(posts_dir) = envoy.get("POST_DIR")
  let assert Ok(static_dir) = envoy.get("STATIC_DIR")
  let assert Ok(out_dir) = envoy.get("OUT_DIR")
  let assert Ok(components_dir) = envoy.get("COMPONENTS_DIR")

  let posts =
    get_posts(posts_dir)
    |> list.map(fn(post) { #(post.metadata.slug, post) })
    |> dict.from_list()

  let tags =
    tag.get_tag_list()
    |> list.map(fn(tag) {
      #(
        tag.tag_to_string(tag.name, True),
        blog.PostList(Some(tag), get_posts(posts_dir)),
      )
    })
    |> dict.from_list()

  let build =
    ssg.new(out_dir)
    |> ssg.add_static_route("/", index.view())
    |> ssg.add_static_route(
      "/blog",
      blog.view(blog.PostList(None, get_posts(posts_dir))),
    )
    |> ssg.add_static_route("/projects", projects.view())
    |> ssg.add_dynamic_route("/blog", posts, post.view)
    |> ssg.add_dynamic_route("/blog/tag", tags, blog.view)
    |> ssg.add_static_dir(static_dir)
    |> ssg.build

  case build {
    Ok(_) -> io.println("Build succeeded!")
    Error(e) -> {
      echo e
      io.println("Build failed!")
    }
  }
  get_components(components_dir)
}

fn get_components(components_dir: String) {
  let assert Ok(paths) = simplifile.read_directory(components_dir)
  use file <- list.map(paths)
  let es_build =
    esgleam.new("./priv/js")
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

fn get_posts(posts_dir: String) -> List(Post) {
  let assert Ok(paths) = simplifile.read_directory(posts_dir)
  use file <- list.map(paths)
  post.parse(path: posts_dir <> "/" <> file)
}
