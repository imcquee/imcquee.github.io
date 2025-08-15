import gleam/list
import pages/post.{type Post}
import simplifile

const posts_dir = "./posts"

pub fn all() -> List(Post) {
  let assert Ok(paths) = simplifile.read_directory(posts_dir)
  use file <- list.map(paths)
  post.parse(path: posts_dir <> "/" <> file)
}
