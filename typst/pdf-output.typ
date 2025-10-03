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
  align(center, text(size: 18pt, font: ("尙古黑體SC", "Noto Sans"), weight: "bold", body))
  line(length: 100%)
  v(1em)
}

// PDF输出主函数
#let render(data, body) = {
  let (language, title, commitSha) = data

  set text(lang: language, font: ("Minion 3", "尙古明體SC"))
  set par(justify: true)
  set heading(numbering: "1.1")

  show math.equation: set text(
    font: (
      (name: "Minion 3", covers: "latin-in-cjk"),
      "Zhuque Fangsong (technical preview)",
      "Minion Math",
    ),
    weight: 400,
  )
  show "。": "．"
  set page(header: add-margin-watermark[
    ©Uwni, All Rights Reserved.
    version: #commitSha
  ])
  artical-title(title)

  body
}
