#import "html.typ"
#import "helper.typ": build-tree, plain-text

#let to-kebab-case(s) = {
  lower(s).replace(" ", "-")
}

#let get-heading-id(id: none, heading) = {
  if heading == none {
    return none
  }

  let h-counter = if id != none {
    // let h-counter = if false {
    id
  } else {
    counter(std.heading).at(heading.location())
  }

  "s" + h-counter.map(str).join("_") + "-" + to-kebab-case(plain-text(heading.body))
}

// 生成目录HTML
#let _generate-toc() = {
  // 设置outline.entry的显示方式
  show outline.entry: it => {
    context {
      // 获取标题计数器值并构建层次化ID
      let id = get-heading-id(it.element)
      let href = "#" + id
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
    let id = get-heading-id(it)
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
    }(class: "post-heading", id: id, html.a(
      class: "heading-anchor",
      href: "#" + id,
      it.body,
    ))
  }


  // 构建标签HTML
  let tags-html = if tags.len() > 0 {
    let tag-links = tags.map(tag => html.a(href: "/collections/?tag=" + tag, "#" + tag)).join(" ")
    html.div(tag-links)
  }

  let sectioned-content = build-tree(body, func: (level: 0, heading: none, body) => {
    if level == 0 {
      return body
    }

    html.section(
      class: "labelled-placeholder",
      heading + body,
    )
  })

  show html.elem.where(tag: "section", attrs: (class: "labelled-placeholder")): it => context {
    let headings = query(selector(heading).after(here()))
    let id-entry = if headings.len() > 0 {
      (aria-labelledby: get-heading-id(headings.first()))
    }
    html.section(
      class: "post-section",
      ..id-entry,
      it.body,
    )
  }

  let local-time = html.div(html.time(class: "local-time", data-utc: date, [Loading...]))

  // let sectioned-content = body
  [
    #html.div(class: "post-container")[
      #html.article[
        #html.div(class: "post-title-container", [
          #html.h1(class: "post-title", title)
          #html.div(class: "post-pdf-download", [
            #html.a(
              href: "/archives/" + sys.inputs.at("fileSlug", default: "unknown") + ".pdf",
              class: "pdf-download-link",
              target: "_blank",
              "📄 Download PDF",
            )
          ])
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
