#let build-tree(
  body,
  func: none,
) = {
  let stack = ()
  let nodes = ()

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
      while stack.len() > 0 and stack.last().heading.depth >= c.depth {
        let node = stack.pop()
        (stack, nodes) = fold(stack, nodes, node)
      }

      stack.push((
        heading: c,
        children: (),
      ))
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


/// stoled from https://github.com/Myriad-Dreamin/Myriad-Dreamin/blob/e860798e5c436ef991ca014091f1f810aa72504b/typ/templates/supports-text.typ#L11
/// Collect text content of element recursively into a single string
/// https://discord.com/channels/1054443721975922748/1088371919725793360/1138586827708702810
/// https://github.com/Myriad-Dreamin/shiroa/issues/55
#let plain-text(it) = {
  if type(it) == str {
    return it
  } else if it == [ ] {
    return " "
  }

  if "child" in it.fields() {
    return plain-text(it.child)
  }

  if "body" in it.fields() {
    return plain-text(it.body)
  }

  if "text" in it.fields() {
    return it.text
  }

  if it.func() == smartquote {
    if it.double {
      return "\""
    } else {
      return "'"
    }
  }

  if "children" in it.fields() {
    return it.children.map(plain-text).filter(t => type(t) == str).join()
  }
}

