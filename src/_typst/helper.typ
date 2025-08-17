#import "html.typ"

#let end-sect = metadata("_tree_end_sect")
#let build-tree(
  body,
  func: none,
  counters: (
    math.equation,
    figure.where(kind: image),
    figure.where(kind: table),
    figure.where(kind: raw),
  ),
  numberings: (
    (math.equation, "(1.1)"),
    (figure, "1.1"),
  ),
) = {
  let stack = ()
  let nodes = ()
  let level-counters = () // 动态维护各层级计数器

  // fold a node into stack or nodes
  let fold(stack, nodes, node) = {
    if stack.len() > 0 {
      stack.last().children.push(node)
    } else {
      nodes.push(node)
    }
    (stack, nodes)
  }

  // traverse body(supposed to be a sequnce) and build tree
  for c in body.children {
    if c.func() == heading {
      // 确保数组长度足够
      while level-counters.len() < c.depth {
        level-counters.push(0)
      }

      // 截断到当前深度，重置更深层计数
      level-counters = level-counters.slice(0, c.depth)

      // 递增当前层级计数
      level-counters.at(c.depth - 1) += 1

      while stack.len() > 0 and stack.last().heading.depth >= c.depth {
        let node = stack.pop()
        (stack, nodes) = fold(stack, nodes, node)
      }

      stack.push((
        heading: c,
        index: level-counters, // 直接存储层级计数器数组
        children: (),
      ))
    } else if c.func() == metadata and c.value == end-sect.value {
      let node = stack.pop()
      (stack, nodes) = fold(stack, nodes, node)
    } else {
      (stack, nodes) = fold(stack, nodes, c)
    }
  }

  // process remaining nodes in stack
  while stack.len() > 0 {
    let node = stack.pop()
    (stack, nodes) = fold(stack, nodes, node)
  }

  // merge continuous content to reduce show-rule depth consumed
  let func-seq = [].func()
  let merge-contents(nodes) = {
    let result = ()
    let current-contents = ()

    for node in nodes {
      if type(node) == dictionary {
        if current-contents.len() > 0 {
          result.push(func-seq(current-contents))
          current-contents = ()
        }
        node.children = merge-contents(node.children)
        result.push(node)
      } else {
        current-contents.push(node)
      }
    }
    if current-contents.len() > 0 {
      result.push(func-seq(current-contents))
    }
    result
  }
  nodes = merge-contents(nodes)

  // convert the tree to content with given func
  let display-func(node, level: 0, wrapping-func: func) = {
    let body = context {
      // store and restore counter values for counters "interrupted" by subsections
      let f(counter-ckpt, children) = {
        // base case
        if children.len() == 0 {
          return
        }
        // process children one by one
        let c = children.first()
        let others = children.slice(1)
        // content -> store counter value after displayed
        if type(c) == content {
          c
          context f(counters.map(x => counter(x)).map(x => x.get().first()), others)
        } // dict(subsection) -> restore counter value after displayed
        else if type(c) == dictionary {
          counters.map(x => counter(x).update(0)).join()
          display-func(level: level + 1, wrapping-func: wrapping-func, c)
          counters.zip(counter-ckpt).map(x => counter(x.first()).update(x.last())).join()
          f(counter-ckpt, others)
        } else {
          panic("unexpected node in document tree")
        }
      }
      // all counters begin with 0
      f((0,) * counters.len(), node.children)
    }

    // call given wrapping-func to finally create contents
    wrapping-func(
      level: level,
      heading: node.heading,
      id: node.at("index", default: ()).map(str).join("-"), // 转换为字符串格式
      context {
        // get heading counter state
        let h-count = if node.heading == none {
          ()
        } else {
          counter(heading).get()
        }

        // util func for build heading-prefixed numbering
        let f-numbering(numbering: "1.1", x) = {
          std.numbering(numbering, ..h-count + (x,))
        }

        // set numberings
        show: x => numberings.fold(
          x,
          (it, config) => {
            let f = config.first()
            set f(numbering: f-numbering.with(numbering: config.last()))
            it
          },
        )
        body
      },
    )
  }
  display-func(
    wrapping-func: func,
    level: 0,
    (
      heading: none,
      children: nodes,
    ),
  )
}

#let inline-css(path: none, raw: none) = {
  let css = if path != none {
    read(path)
  } else {
    raw
  }
  html.style(css)
}