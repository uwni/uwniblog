//themed
#let themed(fn) = {
  fn((color: black))
}

// PDF输出相关功能
#let add-margin-watermark(content) = context {
  let content = rotate(90deg, content)
  place(bottom + left, dx: page.width, content)
}

#let artical-title(body) = {
  align(center, text(size: 18pt, font: ("Noto Sans CJK SC", "Noto Sans"), weight: "bold", body))
  line(length: 100%)
  v(1em)
}

// PDF输出主函数
#let as-pdf-output(title, tags: (), commitSha: none, date: none, genHtml: none, body) = {
  set text(font: ("Libertinus Serif", "尙古明體SC"))
  set par(justify: true)
  show math.equation: set text(
    font: (
      (name: "Libertinus Serif", covers: "latin-in-cjk"),
      "Zhuque Fangsong (technical preview)",
      "Libertinus Math",
    ),
    weight: 400,
  )
  set page(header: add-margin-watermark[
    ©Uwni, All Rights Reserved.
    version: #commitSha
  ])
  artical-title(title)
  body
}
