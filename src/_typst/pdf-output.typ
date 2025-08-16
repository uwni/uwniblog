// PDF输出相关功能

// PDF输出主函数
#let as-pdf-output(title, body) = {
  heading(level: 1, title)
  body
}