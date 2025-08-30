import gleam/int
import lustre
import lustre/element.{type Element}
import lustre/element/html
import lustre/event

pub fn main() {
  let app = lustre.simple(init, update, view)
  let assert Ok(dispatch) = lustre.start(app, "[gleam_example]", Nil)

  dispatch
}

type Model =
  Int

fn init(_) -> Model {
  0
}

pub type Msg {
  Increment
  Decrement
}

fn update(model: Model, msg: Msg) -> Model {
  case msg {
    Increment -> model + 2
    Decrement -> model - 2
  }
}

fn view(model: Model) -> Element(Msg) {
  let count = int.to_string(model)

  html.div([], [
    html.p([], [
      element.text(count <> " ✨"),
    ]),
    html.p([], [
      html.button([event.on_click(Decrement)], [element.text("-")]),
      html.button([event.on_click(Increment)], [element.text("+")]),
    ]),
  ])
}
