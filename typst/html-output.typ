#import "html.typ"
#import "helper.typ": build-tree, inline-css

#let _get_heading_id(heading: none) = {
  let h-counter = if heading == none {
    counter(std.heading).get()
  } else {
    counter(std.heading).at(heading.location())
  }
  h-counter.map(str).join("-")
}

// 生成目录HTML
#let _generate-toc() = {
  // 设置outline.entry的显示方式
  show outline.entry: it => {
    context {
      // 获取标题计数器值并构建层次化ID
      let id = _get_heading_id(heading: it.element)
      let href = "#heading-" + id
      let depth = it.level - 1

      html.li(
        class: "toc-item" + (if depth > 0 { " collapsed" } else { "" }),
        style: "--depth: " + str(depth),
        html.a(
          class: "toc-link",
          href: href,
          it.element.body,
        ),
      )
    }
  }

  // 生成outline并包装在ul中
  html.ul(
    class: "toc-list",
    outline(title: none),
  )
}

#let handle-math(it) = {
  if it.block {
    let count = counter(math.equation).display()
    html.div(class: "typst-equation math-block", style: "text-align: center;", html.frame(it) + count)
  } else {
    html.span(class: "typst-equation math-inline", html.frame(it))
  }
}


// HTML输出主函数
#let as-html-output(title, tags: (), date: none, body) = {
  show image: it => {
    if (it.format != "svg") {
      let alt = if it.alt != none { it.alt } else { "ALT" }
      html.img(src: it.source, alt: alt)
    } else {
      it
    }
  }

  show figure.where(kind: image): it => html.figure(
    class: "typst-figure",
    [
      #it.body
      #it.caption
    ],
  )

  set math.equation(numbering: it => html.div(
    class: "equation-numbering",
    [(#it)],
  ))
  show math.equation: handle-math
  show math.equation: set text(size: 12pt, font: "STIX Two Math")

  show ref: it => {
    it.element
  }

  show heading: it => {
    let id = _get_heading_id()
    // 生成HTML元素，但保持编号功能
    if it.level == 1 {
      html.h2
    } else if it.level == 2 {
      html.h3
    } else if it.level == 3 {
      html.h4
    } else if it.level == 4 {
      html.h5
    } else {
      html.h6
    }(class: "post-heading", id: "heading-" + id, html.a(
      class: "heading-anchor",
      href: "#heading-" + id,
      it.body,
    ))
  }


  // 构建标签HTML
  let tags-html = if tags.len() > 0 {
    let tag-links = tags.map(tag => html.a(href: "/collections/?tag=" + tag, "#" + tag)).join(" ")
    html.div(tag-links)
  }

  // 处理 body - 统一使用 Typst 标题编号
  let sectioned-content = build-tree(body, func: (level: 0, heading: none, id: "", body) => {
    if heading != none {
      html.section(
        aria-labelledby: "heading-" + id,
        class: "post-section",
        heading + body,
      )
    } else {
      html.section(class: "post-section", body)
    }
  })

  let local-time = html.div(html.time(class: "local-time", data-utc: date, [Loading...]))

  // let sectioned-content = body
  [
    #html.div(class: "post-container")[
      #html.article[
        #html.div(class: "post-title-container", [
          #html.h1(class: "post-title", title)
          #html.div(class: "post-meta mobile-meta", [
            #local-time
            #tags-html
          ])
        ])
        #html.div(class: "mobile-toc")[
          #html.details[
            #html.summary[目录]
            #html.nav(
              class: "mobile-toc-nav",
              _generate-toc(),
            )
          ]]
        #html.div(class: "post-content", sectioned-content)
      ]


      #html.aside(
        class: "post-toc",
        html.div(
          class: "toc-container",
          [
            #html.div(
              class: "post-meta desktop-meta",
              [
                #local-time
                #tags-html
              ],
            )
            #html.h3("目录")
            #html.nav(
              class: "toc-nav",
              _generate-toc(),
            )
          ],
        ),
      )
    ]
  ]
}
