#let handle-math(body) = {
  import "mathyml/src/lib.typ" as mathyml
  import mathyml: try-to-mathml
  import mathyml.prelude
  show math.equation: try-to-mathml
  body
}
