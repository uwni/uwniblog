// PDF输出相关功能

// PDF输出主函数
#let as-pdf-output(title, body) = {
  set text(font: (name: "尙古明體SC", covers: "latin-in-cjk"))
  show math.equation: set text(font: "STIX Two Math")

  align(center, text(size: 18pt, font: ("Noto Sans CJK SC", "Noto Sans"), weight: "bold", title))
  line(length: 100%)
  v(1em)
  body
}
