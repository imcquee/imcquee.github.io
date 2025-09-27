import gleam/dict.{type Dict}
import lustre/attribute.{class}
import lustre/element
import lustre/element/html
import stateless_components/color.{type Color}

type Callout {
  Callout(title: String, color: Color, icon: String)
}

fn get_callout(callout_type callout_type: String) {
  case callout_type {
    "info" -> Callout(title: "Info", color: color.Blue, icon: "ℹ️")
    "warning" -> Callout(title: "Warning", color: color.Yellow, icon: "⚠️")
    _ -> panic as "Unknown callout type"
  }
}

pub fn render_callout(attrs: Dict(String, String), code: String) {
  let assert Ok(callout_type) = dict.get(attrs, "type")
  let callout = get_callout(callout_type:)

  html.div([class(color.color_to_string(callout.color) <> " p-4 m-4")], [
    html.p([], [element.text(callout.icon <> " " <> callout.title)]),
    element.unsafe_raw_html("", "div", [], code),
  ])
}
