#let frontmatter(
  ..args,
) = {
  [#metadata(
    args.named(),
  )<frontmatter>]
}

#let get-target() = if "target" in sys.inputs {
  sys.inputs.target
} else {
  panic("target is required for post-template")
}

//! A specified targets arg can override that controlled by genBoth
#let post-template(
  genHtml: true,
  genPdf: true,
  date: none,
  title: "untitled post",
  ..args,
  body,
) = {
  set heading(numbering: "1.1")
  set math.equation(numbering: "(1)")
  let target = get-target()
  if target == "query" {
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
      ..args.named(),
    )
  } else if target == "html" {
    import "html-output.typ": as-html-output
    let date = if "date" in sys.inputs {
      sys.inputs.date
    } else {
      panic("date should be provided by the 11ty side")
    }
    let tags = args.named().at("tags", default: ())
    as-html-output(title, tags: tags, date: date, body)
  } else if target == "pdf" {
    import "pdf-output.typ": as-pdf-output
    as-pdf-output(title, body)
  } else {
    panic("Unknown target: " + target)
  }
}

#let standalone-template(title, body) = {
  let target = get-target()

  if target == "query" {
    frontmatter(
      title: title,
      date: date,
      targets: targets,
      ..args.named(),
    )
  }
}
