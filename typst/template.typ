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

#let links-map(targets, links) = for (i, t) in targets.enumerate() {
  ((t): links.at(i))
}

#let post-template(
  tags: (),
  title: "untitled",
  gen-html: true,
  gen-pdf: true,
  category: none,
  language: "en",
  ..args,
  body,
) = {
  let targets = ()
  if gen-html {
    targets.push("html")
  }
  if gen-pdf {
    targets.push("pdf")
  }
  let frontmatter = (
    title: title,
    language: to-html-lang(language),
    tags: ("posts", ..tags),
    layout: "layouts/post.webc",
    targets: targets,
    ..args.named(),
  )

  if category != none {
    assert(type(category) == str, message: "category must be a string, got " + str(type(category)))
    frontmatter.insert("eleventyNavigation", (
      key: title,
      parent: category,
    ))
  }

  let renderer = (eleventy-data: none) => {
    //merge eleventy-data and frontmatter
    let data = if eleventy-data != none {
      let (metadata, page, target, links) = eleventy-data

      (
        commitSha: metadata.commitSha,
        date: page.date,
        target: target,
        fileSlug: page.fileSlug,
        links: links-map(targets, links),
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

#let category-template(tags: (), title: "", language: "en", ..args, body) = {
  let targets = ("html",)
  let frontmatter = (
    language: to-html-lang(language),
    tags: ("category", ..tags),
    targets: targets,
    layout: "layouts/category-index.webc",
    title: title,
    eleventyNavigation: (
      key: title,
    ),
    ..args.named(),
  )

  let renderer = (eleventy-data: none) => {
    //merge eleventy-data and frontmatter
    let data = if eleventy-data != none {
      let (metadata, page, target, links) = eleventy-data
      (
        commitSha: metadata.commitSha,
        date: page.date,
        target: target,
        fileSlug: page.fileSlug,
        links: links-map(targets, links),
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

