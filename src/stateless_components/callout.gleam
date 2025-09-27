import gleam/dict.{type Dict}
import lustre/attribute.{class}
import lustre/element as lustre_element
import lustre/element/html
import stateless_components/color.{type Color}

type Callout {
  Callout(title: String, text: String, color: Color, icon: String)
}

fn get_callout(
  callout_type callout_type: String,
  callout_text callout_text: String,
) {
  case callout_type {
    "info" ->
      Callout(title: "Info", text: callout_text, color: color.Blue, icon: "ℹ️")
    "warning" ->
      Callout(
        title: "Warning",
        text: callout_text,
        color: color.Yellow,
        icon: "⚠️",
      )
    _ -> panic as "Unknown callout type"
  }
}

pub fn render_callout(attrs: Dict(String, String)) {
  let assert Ok(callout_type) = dict.get(attrs, "type")
  let assert Ok(callout_text) = dict.get(attrs, "text")

  let callout = get_callout(callout_type:, callout_text:)

  html.div([class(color.color_to_string(callout.color) <> " p-4 m-4")], [
    html.p([], [lustre_element.text(callout.icon <> " " <> callout.title)]),
    html.p([class("italic")], [lustre_element.text(callout_text)]),
  ])
}
