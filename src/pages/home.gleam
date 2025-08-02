import content
import lustre/attribute.{class}
import lustre/element.{type Element}
import lustre/element/html
import lustre/element/svg
import lustre/ui
import lustre/ui/button
import lustre/ui/stack

pub fn view() -> Element(a) {
  ui.centre(
    [],
    ui.stack([stack.loose()], [
      ui.centre(
        [class("mt-12")],
        html.img([
          attribute.src("city.png"),
          class("object-cover p-4 h-48 w-48 rounded-full"),
        ]),
      ),
      ui.centre(
        [],
        html.h1([class("text-4xl font-mono text-white")], [
          element.text("imcquee"),
        ]),
      ),
      ui.centre(
        [class("w-screen")],
        html.p([class("max-w-lg font-mono text-white")], [
          element.text(
            "I'm Isaac McQueen 🙋🏾‍♂️ a full-stack software engineer with 5+ years of experience. I use this page to post about things that excite me. You can also access my cv, contacts, and relevant links.",
          ),
        ]),
      ),
      ui.centre(
        [],
        ui.cluster([], [
          ui.button([button.small()], [
            html.a(
              [
                attribute.rel("noopener noreferrer"),
                attribute.target("_blank"),
                attribute.href("https://github.com/imcquee"),
              ],
              [
                ui.cluster([], [
                  html.svg(
                    [
                      attribute.property("xmlns", "http://www.w3.org/2000/svg"),
                      attribute.property("fill", "none"),
                      attribute.property("viewBox", "0 0 24 24"),
                      attribute.property("height", "24"),
                      attribute.property("width", "24"),
                    ],
                    [
                      svg.path([
                        attribute.property(
                          "d",
                          "M12 .297c-6.63 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.6.113.793-.263.793-.583 0-.288-.012-1.237-.017-2.245-3.338.726-4.043-1.416-4.043-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.09-.745.083-.729.083-.729 1.205.085 1.839 1.24 1.839 1.24 1.07 1.835 2.805 1.304 3.493.998.108-.776.418-1.305.76-1.605-2.665-.303-5.466-1.33-5.466-5.93 0-1.312.469-2.384 1.24-3.222-.124-.303-.537-1.523.117-3.176 0 0 1.012-.324 3.312 1.232a11.58 11.58 0 0 1 3.012-.404c1.02.005 2.047.138 3.012.404 2.3-1.556 3.31-1.232 3.31-1.232.655 1.653.242 2.873.118 3.176.773.838 1.238 1.91 1.238 3.222 0 4.61-2.805 5.625-5.478 5.921.43.37.813 1.096.813 2.21 0 1.595-.015 2.877-.015 3.268 0 .323.19.702.799.582C20.565 22.092 24 17.592 24 12c0-6.627-5.373-12-12-12z",
                        ),
                        attribute.property("fill", "currentColor"),
                      ]),
                    ],
                  ),
                  element.text("Github"),
                ]),
              ],
            ),
          ]),
          ui.button([button.small()], [element.text("📃 CV")]),
          ui.button([button.small()], [element.text("✉️ Email")]),
          ui.button([button.small()], [element.text("🚧 Projects")]),
          ui.button([button.small()], [element.text("👨🏿‍💻 Tools")]),
        ]),
      ),
    ]),
  )
  |> content.view_home()
}
