import gleam/list
import gleam/string
import lustre/attribute.{type Attribute, class}
import lustre/element.{type Element}
import lustre/element/html

pub type Color {
  Red
  Green
  Purple
  Pink
  Yellow
  Blue
  Orange
}

pub type Tag {
  Travel
  Programming
  Gleam
  Career
  Languages
  Music
  Opinion
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
    "opinion" -> Ok(TagInfo(Opinion, Purple))
    "languages" -> Ok(TagInfo(Languages, Orange))
    "gleam" -> Ok(TagInfo(Gleam, Pink))
    "career" -> Ok(TagInfo(Career, Yellow))
    _ -> Error(TagNotFound("Tag not found, please add it"))
  }
}

pub fn to_string(tag: Tag, color: Color) -> #(String, String) {
  let tag_string = case tag {
    Programming -> "Programming"
    Music -> "Music"
    Opinion -> "Opinion"
    Travel -> "Travel"
    Languages -> "Languages"
    Gleam -> "Gleam"
    Career -> "Career"
  }
  let color_string = case color {
    Red -> "bg-red-200"
    Green -> "bg-green-200"
    Purple -> "bg-purple-200"
    Blue -> "bg-blue-200"
    Yellow -> "bg-yellow-200"
    Orange -> "bg-orange-200"
    Pink -> "bg-pink-200"
  }
  #(tag_string, color_string)
}

pub fn parse_tags(tags: String, delimiter: String) -> List(TagInfo) {
  string.split(tags, delimiter)
  |> list.filter_map(string_to_tag)
}

pub fn render_tags(
  tags: List(TagInfo),
  tag_attrs: List(Attribute(a)),
) -> Element(a) {
  let tag_list =
    list.map(tags, fn(tag) {
      let #(name, color) = to_string(tag.name, tag.color)

      html.div(
        [
          class(color <> " px-4 border-2 border-black rounded-md"),
        ],
        [html.p(tag_attrs, [element.text(name)])],
      )
    })

  html.div([class("flex flex-row gap-3")], tag_list)
}
