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
  set heading(numbering: "1.1")

  show: if target == "query" {
    [#metadata((
      title: title,
      creationDate: creationDate.display(),
      targets: targets,
      ..args.named(),
    ))<frontmatter>]
  } else if target == "html" {
    import "html-output.typ": as-html-output

    let tags = args.named().at("tags", default: ())
    as-html-output(title, tags: tags, date: creationDate, body)
  } else if target == "pdf" {
    import "pdf-output.typ": as-pdf-output
    as-pdf-output(title, body)
  } else {
    panic("Unknown target: " + target)
  }
}

