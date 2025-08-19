#let handle-math(body) = {
  import "mathyml/src/lib.typ" as mathyml
  import mathyml: try-to-mathml
  import mathyml.prelude
  show math.equation: try-to-mathml
  set text(size: 12pt)
  body
}
