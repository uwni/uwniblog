#let handle-math(it) = {
  import "html.typ"
  set text(size: 12pt, font: "STIX Two Math")
  
  if it.block {
    html.div(class: "math-block", style: "text-align: center;", html.frame(it))
  } else {
    html.span(class: "math-inline", html.frame(it))
  }
}
