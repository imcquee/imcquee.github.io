import gleam/list
import gleam/string
import lustre/attribute.{class}
import lustre/element.{type Element}
import lustre/element/html

pub type Color {
  Red
  Green
  Purple
  Yellow
  Blue
  Orange
}

pub type Tag {
  Travel
  Motivation
  Programming
  Languages
  Music
  Food
}

pub type TagInfo {
  TagInfo(name: Tag, color: Color)
}

pub type TagError {
  TagNotFound(String)
}

pub fn string_to_tag(tag_name: String) -> Result(TagInfo, TagError) {
  case string.lowercase(tag_name) {
    "travel" -> Ok(TagInfo(Travel, Red))
    "programming" -> Ok(TagInfo(Programming, Blue))
    "music" -> Ok(TagInfo(Music, Green))
    "food" -> Ok(TagInfo(Food, Purple))
    "motivation" -> Ok(TagInfo(Motivation, Yellow))
    "languages" -> Ok(TagInfo(Languages, Orange))
    _ -> Error(TagNotFound("Tag not found, please add it"))
  }
}

pub fn to_string(tag: Tag, color: Color) -> #(String, String) {
  let tag_string = case tag {
    Programming -> "Programming"
    Music -> "Music"
    Food -> "Food"
    Travel -> "Travel"
    Motivation -> "Motivation"
    Languages -> "Languages"
  }
  let color_string = case color {
    Red -> "bg-red-200"
    Green -> "bg-green-200"
    Purple -> "bg-purple-200"
    Blue -> "bg-blue-200"
    Yellow -> "bg-yellow-200"
    Orange -> "bg-orange-200"
  }
  #(tag_string, color_string)
}

pub fn parse_tags(tags: String, delimiter: String) -> List(TagInfo) {
  string.split(tags, delimiter)
  |> list.filter_map(string_to_tag)
}

pub fn render_tags(tags: List(TagInfo)) -> Element(a) {
  let tag_list =
    list.map(tags, fn(tag) {
      let #(name, color) = to_string(tag.name, tag.color)

      html.div(
        [
          class(color <> " px-4 border-2 border-black rounded-md"),
        ],
        [
          element.text(name),
        ],
      )
    })

  html.div([class("flex flex-row gap-3")], tag_list)
}
