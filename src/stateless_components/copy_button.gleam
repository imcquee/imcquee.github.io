import lustre/attribute.{class}
import lustre/element
import lustre/element/html

pub fn render_copy_button(text_to_copy: String) {
  html.div(
    [
      attribute.attribute("copy_button", ""),
      attribute.attribute("data-copy", text_to_copy),
    ],
    [
      html.p(
        [
          class(
            "cursor-pointer hover:scale-120 transition-transform duration-200 text-xl",
          ),
        ],
        [element.text("📋")],
      ),
    ],
  )
}
