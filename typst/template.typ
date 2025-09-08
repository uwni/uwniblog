#let frontmatter(
  ..args,
) = {
  [#metadata(
    args.named(),
  )<frontmatter>]
}

#let get-compile-mode() = {
  if "target" in sys.inputs {
    return sys.inputs.target
  }

  // for preview
  return "pdf"
}

#let _themes = (
  (name: "light-mode", color: black),
  (name: "dark-mode", color: white),
)

#let themed(fn) = {
  if get-compile-mode() != "html" {
    return fn((color: black))
  }
  import "html.typ"
  for theme in _themes {
    let result = fn((
      color: color.rgb(theme.color),
    ))
    html.div(class: "typst-themed " + theme.name, html.frame(result))
  }
}

//! A specified targets arg can override that controlled by genBoth
#let post-template(
  genHtml: true,
  genPdf: true,
  date: none,
  title: "untitled post",
  language: "en",
  ..args,
  body,
) = {
  set heading(numbering: "1.1")
  set math.equation(numbering: "(1)")
  set text(lang: language)

  let compile-mode = get-compile-mode()
  if compile-mode == "query" {
    let date = if date != none {
      date
    } else {
      "git Last Modified"
    }
    let targets = ("html",) * int(genHtml) + ("pdf",) * int(genPdf)

    frontmatter(
      title: title,
      date: date,
      targets: targets,
      language: language,
      ..args.named(),
    )
  } else if compile-mode == "html" {
    import "html-output.typ": as-html-output
    let date = if "date" in sys.inputs {
      sys.inputs.date
    } else {
      panic("date should be provided by the 11ty side")
    }
    let tags = args.named().at("tags", default: ())
    as-html-output(title, tags: tags, date: date, genPdf: genPdf, body)
  } else if compile-mode == "pdf" {
    import "pdf-output.typ": as-pdf-output
    as-pdf-output(title, body)
  } else {
    panic("Unknown target: " + target)
  }
}

#let standalone-template(title, body) = {
  let compile-mode = get-compile-mode()

  if compile-mode == "query" {
    frontmatter(
      title: title,
      date: date,
      layout: "",
      targets: targets,
      ..args.named(),
    )
  }
}
