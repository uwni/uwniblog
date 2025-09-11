#let _env_state = state("env", (:))

#let _reset_env_counting() = _env_state.update(it => it.keys().map(k => (k, 0)).to-dict())

#let config = (
  _sans_font: "Barlow",
  _main_size: 1em,
  _page_num_size: 1em,
  _qed_symbol: $qed$,
  _envskip: 1em,
  i18n: (
    chapter: "Chapter",
    section: "Section",
    appendix: "Appendix",
    proof: (name: "Proof.", supplement: "Proof"),
    proposition: (name: "Proposition", supplement: "Proposition"),
    axiom: (name: "Axiom", supplement: "Axiom"),
    example: (name: "Example", supplement: "Example"),
    definition: (name: "Definition", supplement: "Definition"),
    bibliography: "Bibliography",
    index: "Index",
    toc: "Table of Contents",
  ),
  _color_palette: (
    accent: black,
    grey: rgb(100, 100, 100),
    grey-light: rgb(224, 228, 228),
  ),
)

#let accent-frame-heading(number: none, name, title) = {
  set text(
    font: config._sans_font,
    weight: 500,
    tracking: 0.07em,
    size: config._main_size,
    fill: config._color_palette.accent,
  )

  let heading = if number != none {
    // set text(fill: config._color_palette.grey)
    name + h(.25em) + number + h(.5em) + title
  } else {
    name + h(.5em) + title
  }
  block(heading)
}

#let accent-frame-heading-html(number: none, name, title) = {
  import "html.typ"

  [
    #html.div(class: "environment-kind")[#name #number\. ]
    #if title != none [
      #html.div(class: "environment-title")[ (#title)]
    ]
  ]
}

#let accent-frame() = (
  fill: config._color_palette.grey-light,
  width: 100%,
  outset: 0pt,
  inset: 1em,
  breakable: true,
)

#let example-heading(number: none, name, title) = {
  set text(
    font: config._sans_font,
    weight: 500,
    tracking: 0.07em,
    size: config._main_size,
    fill: config._color_palette.accent,
  )
  block(
    [#name #number #title],
    spacing: 1em,
    sticky: true,
    stroke: (top: gradient.linear(config._color_palette.accent, white)),
    outset: (x: 1em, top: 1em),
  )
}


#let example-bottomdeco() = {
  block(height: 1pt, width: 1em, fill: config._color_palette.accent, outset: 0pt, above: 0pt, breakable: false)
  v(config._envskip, weak: true)
}

#let solid-frame() = (
  stroke: (left: (thickness: .25em, paint: config._color_palette.accent)),
  width: 100%,
  outset: (bottom: 1pt, top: 0.5pt),
  inset: 1em,
  breakable: true,
)

#let plain-frame-heading(number: none, name, title) = {
  text(style: "italic", name) + if title != none [(#title)]
}

#let plain-frame-heading-html(number: none, name, title) = {
  import "html.typ"

  html.span(name, style: "font-style: italic;") + if title != none [(#title)]
}

#let plain-frame() = {
  (width: 100%)
}

#let paged_environment(
  kind: none,
  topdeco: { v(config._envskip, weak: true) },
  bottomdeco: { v(config._envskip, weak: true) },
  frame: none,
  heading: none,
  title: none,
  body,
  body-processor: it => it,
  label: none,
  numbered: true,
) = [
  #_env_state.update(it => it + (str(kind): it.at(kind, default: 0) + 1))
  #show figure.where(kind: kind): set block(breakable: true)
  #show figure.where(kind: kind): it => it.body

  #let i18n = config.i18n.at(kind)
  #let (name, supplement) = if type(i18n) == dictionary {
    (i18n.name, i18n.supplement)
  } else if type(i18n) == str {
    (i18n, i18n)
  } else { panic("Invalid i18n entry for kind: " + kind) }

  #figure(kind: kind, supplement: supplement, placement: none, caption: none, {
    set align(left)
    topdeco
    block(breakable: true, ..frame(), [
      #let number = if numbered { context [#_env_state.get().at(kind)] }
      #heading(number: number, name, title)
      #body-processor(body)
    ])
    bottomdeco
  }) #label
]

#let html_environment(
  // config
  kind: none,
  frame-class: none,
  heading: none,
  label: none,
  compact: false,
  // data
  title: none,
  numbered: true,
  body-processor: it => it,
  body,
) = [
  #import "html.typ"
  #_env_state.update(it => it + (str(kind): it.at(kind, default: 0) + 1))

  #let i18n = config.i18n.at(kind)
  #let (name, supplement) = if type(i18n) == dictionary {
    (i18n.name, i18n.supplement)
  } else if type(i18n) == str {
    (i18n, i18n)
  } else { panic("Invalid i18n entry for kind: " + kind) }

  #context {
    let id = if label != none { (id: str(label)) }
    let number = if numbered { _env_state.get().at(kind) }
    html.div(
      class: "environment " + frame-class + " environment-" + kind,
      ..id,
      [
        #html.div(
          class: "environment-header" + if title == none { " inlined" },
          heading(number: number, name, title),
        )
        #html.div(
          class: "environment-body",
          body-processor(body),
        )
      ],
    )
  }
]

#let environment(
  kind: "",
  topdeco: { v(config._envskip, weak: true) },
  bottomdeco: { v(config._envskip, weak: true) },
  paged-frame: none,
  frame-class: none,
  paged-heading: none,
  html-heading: none,
  compact: false,
  numbered: true,
  label: none,
  paged-body-processor: it => it,
  html-body-processor: it => it,
) = (..args) => if "target" in sys.inputs and sys.inputs.target == "html" {
  html_environment(
    kind: kind,
    heading: html-heading,
    label: label,
    compact: compact,
    frame-class: frame-class,
    numbered: numbered,
    body-processor: html-body-processor,
    ..args,
  )
} else {
  paged_environment(
    kind: kind,
    topdeco: topdeco,
    bottomdeco: bottomdeco,
    frame: paged-frame,
    heading: paged-heading,
    label: label,
    numbered: numbered,
    body-processor: paged-body-processor,
    ..args,
  )
}

#let example = environment(
  kind: "example",
  paged-frame: solid-frame,
  paged-heading: example-heading,
  html-heading: example-heading,
  bottomdeco: example-bottomdeco(),
  topdeco: { v(config._envskip, weak: true) },
)

#let proposition = environment(
  kind: "proposition",
  paged-frame: accent-frame,
  frame-class: "accent-frame",
  paged-heading: accent-frame-heading,
  html-heading: accent-frame-heading-html,
)

#let axiom = environment(
  kind: "axiom",
  paged-frame: accent-frame,
  frame-class: "accent-frame",
  paged-heading: accent-frame-heading,
  html-heading: accent-frame-heading-html,
  compact: true,
)


#let highlighteq(body) = {
  $
    #box(stroke: config._color_palette.grey, inset: 1em, body)
  $
}

#let definition = environment(
  kind: "definition",
  paged-frame: accent-frame,
  frame-class: "accent-frame",
  paged-heading: accent-frame-heading,
  html-heading: accent-frame-heading-html,
  compact: true,
)

#let proof-html-processor(it) = {
  import "html.typ"
  let qed_symbol = html.span(config._qed_symbol, style: "float: right;")
  it + qed_symbol
}

#let proof = {
  let qed_symbol = text(config._color_palette.accent, config._qed_symbol)
  environment(
    numbered: false,
    kind: "proof",
    paged-frame: plain-frame,
    frame-class: "plain-frame",
    paged-heading: plain-frame-heading,
    html-heading: plain-frame-heading-html,
    paged-body-processor: it => it + h(1fr) + qed_symbol,
    html-body-processor: proof-html-processor,
  )
}
