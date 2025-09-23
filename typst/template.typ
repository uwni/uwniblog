#import "/node_modules/eleventy-plugin-typst/typst/template.typ": compilation-mode, fncall, template-base

#import "mathyml/src/prelude.typ": *

#import if compilation-mode == "html" {
  "html-output.typ"
} else {
  "pdf-output.typ"
}: render, themed

#let to-html-lang(lang) = {
  if lang == "en" {
    "en"
  } else if lang == "zh" or lang == "lzh" {
    "zh"
  }
}

#let post-template(tags: (), gen-html: true, gen-pdf: true, language: "en", ..args, body) = {
  let targets = ()
  if gen-html {
    targets.push("html")
  }
  if gen-pdf {
    targets.push("pdf")
  }
  let frontmatter = (
    language: to-html-lang(language),
    tags: ("posts", ..tags),
    layout: "layouts/post.webc",
    targets: targets,
    ..args.named(),
  )

  let renderer = (eleventy-data: none) => {
    //merge eleventy-data and frontmatter
    let data = if eleventy-data != none {
      let (metadata, page, target, links) = eleventy-data
      if links.len() == 2 {

      }
      (
        commitSha: metadata.commitSha,
        date: page.date,
        target: target,
        fileSlug: page.fileSlug,
      )
    } else {
      (commitSha: "Unknown")
    }
    render(frontmatter + data, body)
  }

  template-base(
    renderer: renderer,
    ..frontmatter,
  )
}

#let category-template(tags: (), language: "en", ..args, body) = {
  let frontmatter = (
    language: to-html-lang(language),
    tags: ("category", ..tags),
    targets: ("html",),
    layout: "layouts/category-index.webc",
    ..args.named(),
  )

  let renderer = (eleventy-data: none) => {
    //merge eleventy-data and frontmatter
    let data = if eleventy-data != none {
      let (metadata, page, target) = eleventy-data
      (
        commitSha: metadata.commitSha,
        date: page.date,
        target: target,
        fileSlug: page.fileSlug,
      )
    } else {
      (commitSha: "Unknown")
    }
    render(frontmatter + data, body)
  }

  template-base(
    renderer: renderer,
    ..frontmatter,
  )
}

