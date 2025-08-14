#let _parse-datetime(s) = datetime(..json(bytes(s)))

#let _11ty_ref_by_path(path, body) = {
  import "html.typ"
  div(
    a(href: path, body),
  )
}

#let _as-html-output(body) = {
  body
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
    _as-html-output(body)
  } else if target == "pdf" {
    _as-pdf-output(title, body)
  } else {
    panic("Unknown target: " + target)
  }
}


