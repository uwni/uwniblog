#import "/node_modules/eleventy-plugin-typst/typst/template.typ": (
  commitSha, compilation-mode, get-compile-data, template-base,
)
#import "mathyml/src/prelude.typ": *

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

#let post-template(language: "en", ..args) = template-base(
  renderer: if compilation-mode == "html" {
    import "html-output.typ": as-html-output
    as-html-output
  } else {
    import "pdf-output.typ": as-pdf-output
    as-pdf-output
  },
  language: to-html-lang(language),
  ..args,
)
