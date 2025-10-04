import gleam/string

pub fn cn(classname: List(String)) {
  string.join(classname, " ")
}
