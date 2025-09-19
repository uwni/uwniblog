#import "/node_modules/eleventy-plugin-typst/typst/template.typ": (
  commitSha, compilation-mode, get-compile-data, template-base,
)
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

#let post-template(language: "en", ..args) = template-base(
  renderer: render,
  language: to-html-lang(language),
  ..args,
)
