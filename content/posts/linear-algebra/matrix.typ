#import "/typst/environment.typ": *
#import "index.typ": *

#let index(..args, body) = body
#let eu = $upright(e)$
#let im = $upright(i)$

#show: post-template.with(
  title: "矩陣論",
  tags: ("Mathematics", "Algebra"),
  language: "lzh",
)

= 從高斯消去法說起
尝试考虑解以下方程组
$
  cases(
    2&x + 3&y +  &z = 1,
    4&x +  &y + 5&z = 2,
     &x + 2&y + 3&z = 3,
  )
$

= 矩陣