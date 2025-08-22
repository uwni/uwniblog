#let handle-math(it) = {
  import "html.typ"
  set text(size: 12pt, font: ("STIX Two Math", "尙古明體SC"))
  
  if it.block {
    let count = counter(math.equation).display()
    html.div(class: "math-block", style: "text-align: center;", html.frame(it) + count)
  } else {
    html.span(class: "math-inline", html.frame(it))
  }
}
