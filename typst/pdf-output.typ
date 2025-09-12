//themed
#let themed(fn) = {
  fn((color: black))
}

// PDF输出相关功能
#let add-margin-watermark(content) = context {
  set text(top-edge: "bounds", bottom-edge: "bounds")
  place(top + left, dy: page.height + par.leading, content)
}

// PDF输出主函数
#let as-pdf-output(title, body) = {
  set text(font: ((name: "Libertinus Serif", covers: "latin-in-cjk"), "尙古明體SC"))
  show math.equation: set text(font: (
    (name: "Libertinus Serif", covers: "latin-in-cjk"),
    "尙古明體SC",
    "Libertinus Math",
  ), weight: 400)
  set page(header: add-margin-watermark[©Uwni, All Rights Reserved])
  align(center, text(size: 18pt, font: ("Noto Sans CJK SC", "Noto Sans"), weight: "bold", title))
  line(length: 100%)
  v(1em)
  body
}