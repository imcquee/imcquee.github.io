import gleam/list
import gleam/string

pub type Color {
  Red
  Green
  Purple
  Yellow
  Blue
}

pub type Tag {
  Travel
  Motivation
  Programming
  Music
  Food
}

pub type TagInfo {
  TagInfo(name: Tag, color: Color)
}

pub type TagError {
  TagNotFound(String)
}

pub fn color_to_tailwind_bg(color: Color) -> String {
  case color {
    Red -> "bg-red-200"
    Green -> "bg-green-200"
    Purple -> "bg-purple-200"
    Blue -> "bg-blue-200"
    Yellow -> "bg-yellow-200"
  }
}

pub fn string_to_tag(tag_name: String) -> Result(TagInfo, TagError) {
  case string.lowercase(tag_name) {
    "travel" -> Ok(TagInfo(Travel, Red))
    "programming" -> Ok(TagInfo(Programming, Blue))
    "music" -> Ok(TagInfo(Music, Green))
    "food" -> Ok(TagInfo(Food, Purple))
    "motivation" -> Ok(TagInfo(Motivation, Yellow))
    _ -> Error(TagNotFound("Tag not found, please add it"))
  }
}

pub fn to_string(tag: Tag, color: Color) -> #(String, String) {
  let tag_string = case tag {
    Programming -> "Progamming"
    Music -> "Music"
    Food -> "Food"
    Travel -> "Travel"
    Motivation -> "Motivation"
  }
  let color_string = case color {
    Red -> "bg-red-200"
    Green -> "bg-green-200"
    Purple -> "bg-purple-200"
    Blue -> "bg-blue-200"
    Yellow -> "bg-yellow-200"
  }
  #(tag_string, color_string)
}

pub fn parse_tags(tags: String, delimiter: String) -> List(TagInfo) {
  string.split(tags, delimiter)
  |> list.filter_map(string_to_tag)
}
