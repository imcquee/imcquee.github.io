import gleam/list
import gleam/string
import lustre/attribute.{type Attribute, class}
import lustre/element.{type Element}
import lustre/element/html
import stateless_components/link

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

pub fn get_tag_list() {
  [
    TagInfo(Travel, Red),
    TagInfo(Programming, Blue),
    TagInfo(Music, Green),
    TagInfo(Opinion, Purple),
    TagInfo(Languages, Orange),
    TagInfo(Gleam, Pink),
    TagInfo(Career, Yellow),
  ]
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

pub fn tag_to_string(tag: Tag, lower: Bool) {
  let upper_tag = case tag {
    Programming -> "Programming"
    Music -> "Music"
    Opinion -> "Opinion"
    Travel -> "Travel"
    Languages -> "Languages"
    Gleam -> "Gleam"
    Career -> "Career"
  }

  case lower {
    True -> string.lowercase(upper_tag)
    False -> upper_tag
  }
}

pub fn tag_color_to_string(color: Color) {
  case color {
    Red -> "bg-red-200"
    Green -> "bg-green-200"
    Purple -> "bg-purple-200"
    Blue -> "bg-blue-200"
    Yellow -> "bg-yellow-200"
    Orange -> "bg-orange-200"
    Pink -> "bg-pink-200"
  }
}

pub fn parse_tags(tags: String, delimiter: String) -> List(TagInfo) {
  string.split(tags, delimiter)
  |> list.filter_map(string_to_tag)
}

pub fn render_tags(
  tags: List(TagInfo),
  tag_attrs: List(Attribute(a)),
  clickable: Bool,
) -> Element(a) {
  let tag_list =
    list.map(tags, fn(tag) {
      let #(name, color) = #(
        tag_to_string(tag.name, False),
        tag_color_to_string(tag.color),
      )

      case clickable {
        True ->
          link.render_link(
            link.Internal("/blog/tag/" <> tag_to_string(tag.name, True)),
            [
              class(
                color
                <> " px-4 border-2 border-black rounded-md cursor-pointer select-none transition ease-out duration-200 hover:bg-black/5 hover:shadow-md hover:-translate-y-0.5
          active:translate-y-0 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-black focus-visible:ring-offset-2",
              ),
            ],
            [html.p(tag_attrs, [element.text(name)])],
          )
        False ->
          html.div(
            [
              class(color <> " px-4 border-2 border-black rounded-md"),
            ],
            [html.p(tag_attrs, [element.text(name)])],
          )
      }
    })

  html.div([class("flex flex-row flex-wrap gap-3")], tag_list)
}
