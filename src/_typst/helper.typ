#let _parse-datetime(s) = datetime(..json(bytes(s)))

#let _11ty_ref_by_path(path, body) = {
  import "html.typ"
  div(
    a(href: path, body),
  )
}

#let _as-html-output(title, tags: (), date: none, body) = {
  show figure.where(kind: image): html.frame
  import "html.typ"
  let date-str = date.display()

  // 构建标签HTML
  let tags-html = if tags.len() > 0 {
    let tag-links = tags.map(tag => html.a(href: "/tags/" + tag + "/", "#" + tag)).join(" ")
    html.span(" tags: " + tag-links)
  }

  // 生成完整的post布局HTML
  [
    #html.div(class: "post-layout")[
      #html.div(class: "mobile-toc")[
        #html.details[
          #html.summary[📖 目录]
          #html.nav(
            class: "mobile-toc-nav",
            id: "mobile-table-of-contents",
            "<!-- 移动端目录 -->",
          )
        ]]

      #html.div(
        class: "post-main",
        html.article(
          class: "post",
          [
            #html.div(
              class: "post-title-section",
              [
                #html.h1(class: "post-title", title)
                #html.div(
                  class: "post-meta",
                  [
                    #html.time(date-str)
                    #tags-html
                  ],
                )
              ],
            )
            #html.div(
              class: "post-content",
              body,
            )
          ],
        ),
      )

      #html.aside(
        class: "post-toc",
        html.div(
          class: "toc-container",
          [
            #html.h3("目录")
            #html.nav(
              class: "toc-nav",
              id: "table-of-contents",
              "<!-- 目录将通过JavaScript生成 -->",
            )
          ],
        ),
      )
    ]
  ]
}

#let _as-pdf-output(title, body) = {
  heading(level: 1, title)
  body
}

//! A specified targets arg can override that controlled by genBoth
#let post-template(
  genHtml: true,
  genPdf: true,
  creationDate: datetime.today(),
  title: "untitled post",
  ..args,
  body,
) = {
  let targets = ("html",) * int(genHtml) + ("pdf",) * int(genPdf)
  assert("target" in sys.inputs)
  let target = sys.inputs.target

  show: if target == "query" {
    [#metadata((
      title: title,
      creationDate: creationDate.display(),
      targets: targets,
      ..args.named(),
    ))<frontmatter>]
  } else if target == "html" {
    let tags = args.named().at("tags", default: ())
    _as-html-output(title, tags: tags, date: creationDate, body)
  } else if target == "pdf" {
    _as-pdf-output(title, body)
  } else {
    panic("Unknown target: " + target)
  }
}


