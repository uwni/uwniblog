#import "/typst/environment.typ": *
#import "/typst/template.typ": *
#import "@preview/fletcher:0.5.8": diagram, edge, node

#let index(..args, body) = body
#let eu = $upright(e)$
#let im = $upright(i)$

#show: post-template.with(
  title: "分析學其零：集合論",
  tags: ("Mathematics", "Analysis", "Algebra"),
  language: "lzh",
)

= 有序對
#definition(title: [$n$元組])[
  $
    () := {{}} \
    X
  $
]
