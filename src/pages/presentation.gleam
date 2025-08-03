import content
import lustre/element.{type Element}
import lustre/ui
import lustre/ui/stack

pub fn view() -> Element(a) {
  ui.centre([], ui.stack([stack.loose()], [element.text("Hello")]))
  |> content.view_home()
}
