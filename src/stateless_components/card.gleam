import app/utilities/classname.{cn}
import lustre/attribute.{type Attribute, classes}
import lustre/element.{type Element}
import lustre/element/html

pub fn render_card(
  is_clickable: Bool,
  attrs: List(Attribute(a)),
  content: List(Element(a)),
) {
  html.div(
    [
      classes([
        #(cn(["rounded-md", "border-2", "border-black", "bg-white"]), True),
        #(
          cn([
            "cursor-pointer",
            "select-none",
            "transition",
            "ease-out",
            "duration-200",
            "hover:bg-black/5",
            "hover:shadow-md",
            "hover:-translate-y-0.5",
            "active:translate-y-0",
            "focus-visible:outline-none",
            "focus-visible:ring-2",
            "focus-visible:ring-black",
            "focus-visible:ring-offset-2",
          ]),
          is_clickable,
        ),
      ]),
      ..attrs
    ],
    content,
  )
}
