#import "/typst/template.typ": post-template

#show: post-template.with(
  title: "404 Not Found",
  layout: "layouts/standalone.webc",
  genPdf: false,
)
