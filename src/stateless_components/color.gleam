pub type Color {
  Red
  Green
  Purple
  Pink
  Yellow
  Blue
  Orange
}

pub fn color_to_string(color: Color) {
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
