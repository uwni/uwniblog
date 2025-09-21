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

#let post-template(tags: (), language: "en", ..args, body) = {
  let frontmatter = (
    language: to-html-lang(language),
    tags: ("posts", ..tags),
    gen-html: true,
    gen-pdf: true,
    layout: "layouts/post.webc",
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

#let category-template(tags: (), language: "en", ..args, body) = {
  let frontmatter = (
    language: to-html-lang(language),
    tags: ("category", ..tags),
    gen-html: true,
    gen-pdf: false,
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

