// PDF输出相关功能

// PDF输出主函数
#let as-pdf-output(title, body) = {
  set text(font: (name: "尙古明體SC", covers: "latin-in-cjk"))
  show math.equation: set text(font: "STIX Two Math")

  heading(level: 1, title)
  body
}
