
#let _parse-datetime(s) = datetime(..json(bytes(s)))

#let _11ty_ref_by_path(path, body) = {
  import "html.typ"
  div(
    a(href: path, body),
  )
}

#let _compilation_mode() = {
  assert("target" in sys.inputs)
  sys.inputs.mode == "query"
}

/* Exported */
#let frontmatter(data) = [
  #metadata(
    data,
  )<frontmatter>
]

//! A specified targets arg can override that controlled by genBoth
#let post-template(genHtml: true, genPdf: true, creationDate: datetime.today(), ..args, body) = {
  let targets = ("html",) * int(genHtml) + ("pdf",) * int(genPdf)

  if "target" in sys.inputs and sys.inputs.target == "query" {
    return frontmatter((
      title: "untitled post",
      creationDate: creationDate.display(),
      targets: targets,
      ..args.named(),
    ))
  }

  body
}


