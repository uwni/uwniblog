// PDF输出相关功能

// PDF输出主函数
#let as-pdf-output(title, body) = {
  set text(font: "尙古明體SC")
  show math.equation: set text(font: ("STIX Two Math", "尙古明體SC"))

  heading(level: 1, title)
  body
}
