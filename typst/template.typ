#import "mathyml/src/prelude.typ": *

#let frontmatter(
  ..args,
) = {
  [#metadata(
    args.named(),
  )<frontmatter>]
}

#let get-compile-data(..args) = sys.inputs.at(..args)
#let compilation-mode = get-compile-data("target", default: "pdf")
#let commitSha = get-compile-data("commitSha", default: none)

#let themed = if compilation-mode == "html" {
  import "html-output.typ": themed
  themed
} else {
  import "pdf-output.typ": themed
  themed
}

#let to-html-lang(lang) = {
  if lang == "en" {
    "en"
  } else if lang == "zh" or lang == "lzh" {
    "zh"
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
  if compilation-mode == "query" {
    let date = if date != none {
      date
    } else {
      "git Last Modified"
    }
    let targets = ("html",) * int(genHtml) + ("pdf",) * int(genPdf)

    return frontmatter(
      title: title,
      date: date,
      targets: targets,
      language: to-html-lang(language),
      ..args.named(),
    )
  }

  set heading(numbering: "1.1")
  set math.equation(numbering: "(1)")
  set text(lang: language)
  let tags = args.named().at("tags", default: ())

  if compilation-mode == "html" {
    import "html-output.typ": as-html-output
    let date = if "date" in sys.inputs {
      sys.inputs.date
    } else {
      panic("date should be provided by the 11ty side")
    }
    as-html-output(title, tags: tags, date: date, genPdf: genPdf, body)
  } else if compilation-mode == "pdf" {
    import "pdf-output.typ": as-pdf-output
    as-pdf-output(title, tags: tags, commitSha: commitSha, date: date, genHtml: genHtml, body)
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
