#import "/typst/template.typ": *

#let category-key = "分析學"

#let post-template = post-template.with(
  category: category-key,
)

#show: category-template.with(
  title: category-key,
  tags: ("Mathematics", "Analysis"),
  language: "lzh",
)

夫分析學者，數學之基也。然則其理實纏綿，非一言所能盡也。
