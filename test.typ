
#set heading(numbering: "1.1")

= A

== N
== N
== N

#let _generate-toc() = {
  // 设置outline.entry的显示方式
  show outline.entry: it => {
    context {
      // 获取标题计数器值并构建层次化ID
      let h-counter = counter(heading).at(it.element.location())
      let id = "section-" + h-counter.map(str).join("-")
      [#id #it.element]
    }
  }

  outline(title: none)
}

#_generate-toc()
