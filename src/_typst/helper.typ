#import "html.typ"

#let end-sect = metadata("_tree_end_sect")
#let build-tree(
  body,
  func: none,
) = {
  let stack = ()
  let nodes = ()
  let level-counters = () // 动态维护各层级计数器，用于生成 id

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
        index: level-counters, // 直接存储层级计数器数组，用于生成 id
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
    let body = {
      // process children one by one
      let f(children) = {
        // base case
        if children.len() == 0 {
          return
        }
        // process children one by one
        let c = children.first()
        let others = children.slice(1)
        // content -> display content
        if type(c) == content {
          c
          f(others)
        } // dict(subsection) -> display subsection
        else if type(c) == dictionary {
          display-func(level: level + 1, wrapping-func: wrapping-func, c)
          f(others)
        } else {
          panic("unexpected node in document tree")
        }
      }
      f(node.children)
    }

    // call given wrapping-func to finally create contents
    wrapping-func(
      level: level,
      heading: node.heading,
      id: node.at("index", default: ()).map(str).join("-"), // 转换为字符串格式
      body,
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