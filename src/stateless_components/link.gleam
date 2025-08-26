import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub type Link {
  Internal(String)
  External(String)
}

pub fn render_link(
  link: Link,
  attributes: List(Attribute(a)),
  content: List(Element(a)),
) -> Element(a) {
  case link {
    Internal(src) -> html.a([attribute.href(src), ..attributes], content)
    External(src) ->
      html.a(
        [
          attribute.rel("noopener noreferrer"),
          attribute.target("_blank"),
          attribute.href(src),
          ..attributes
        ],
        content,
      )
  }
}
