#let frontmatter(data) = [
  #metadata(
    data,
  )<frontmatter>
]

#let _parse-datetime(s) = datetime(..json(bytes(s)))

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
