#import "html.typ"
#import "helper.typ": build-tree

// HTML输出相关功能

// 生成目录HTML
#let _generate-toc() = {
  // 设置outline.entry的显示方式
  show outline.entry: it => {
    context {
      // 获取标题计数器值并构建层次化ID
      let h-counter = counter(heading).at(it.element.location())
      let id = h-counter.map(str).join("-")
      let href = "#heading-" + id
      let depth = it.level - 1

      html.li(
        class: "toc-item",
        style: "--depth: " + str(depth),
        data-section-id: "section-" + id,
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


// HTML输出主函数
#let as-html-output(title, tags: (), date: none, body) = {
  show figure.where(kind: image): html.frame

  show heading: it => {
    let id = counter(heading).at(here()).map(str).join("-")
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
    }(class: "post-heading", id: "heading-" + id, it.body)
  }

  let date-str = date.display()

  // 构建标签HTML
  let tags-html = if tags.len() > 0 {
    let tag-links = tags.map(tag => html.a(href: "/tags/" + tag + "/", "#" + tag)).join(" ")
    html.span(" tags: " + tag-links)
  }

  // 处理 body 内容，将其按标题分组为 sections
  let sectioned-content = build-tree(body, func: (level: 0, id: (), heading: none, body) => {
    let id = id.map(str).join("-")
    html.section(id: "section-" + id, data-toc-id: "toc-link-" + id, heading + body)
  })

  // let sectioned-content = body
  // 生成完整的post布局HTML
  [
    #html.div(class: "post-layout")[
      #html.div(class: "mobile-toc")[
        #html.details[
          #html.summary[📖 目录]
          #html.nav(
            class: "mobile-toc-nav",
            _generate-toc(),
          )
        ]]


      #html.article(class: "post post-main")[
        #html.div(class: "post-title-container", [
          #html.h1(class: "post-title", title)
          #html.div(class: "post-meta mobile-meta", [
            #html.time(date-str)
            #tags-html
          ])
        ])
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
                #html.time(date-str)
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
