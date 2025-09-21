#import "/typst/environment.typ": *
#import "/typst/template.typ": *

#show: post-template.with(
  title: "Math Test",
  description: "A test post for math rendering",
  tags: ("math", "test"),
  eleventyNavigation: (
    key: "Math Test",
    parent: "Test",
    order: 1,
  ),
)


本页面用于测试各种功能
$
  sin x
$

#fncall(```js
1 + 1
```)
