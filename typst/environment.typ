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
    proposition: (name: "PROPOSITION", supplement: "Proposition"),
    example: (name: "EXAMPLE", supplement: "Example"),
    definition: (name: "DEFINITION", supplement: "Definition"),
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

#let accent-frame-heading(it) = {
  set text(
    font: config._sans_font,
    weight: 500,
    tracking: 0.07em,
    size: config._main_size,
    fill: config._color_palette.accent,
  )
  box(it)
}

#let accent-frame() = (
  fill: config._color_palette.grey-light,
  width: 100%,
  outset: 0pt,
  inset: 1em,
  breakable: true,
)

#let example-heading(it) = {
  set text(
    font: config._sans_font,
    weight: 500,
    tracking: 0.07em,
    size: config._main_size,
    fill: config._color_palette.accent,
  )
  block(
    it,
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

#let plain-frame-heading(it) = {
  text(style: "italic", it)
}

#let plain-frame() = {
  (width: 100%)
}

#let paged_environment(
  kind,
  topdeco: { v(config._envskip, weak: true) },
  bottomdeco: { v(config._envskip, weak: true) },
  frame,
  heading,
  title,
  body,
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
      #heading(if numbered {
        // set text(fill: config._color_palette.grey)
        let num = context [#_env_state.get().at(kind)]
        name + h(.25em) + num + h(.5em) + title
      } else {
        name + h(.5em) + title
      })
      #body
    ])
    bottomdeco
  }) #label
]

#let html_environment(
  kind,
  topdeco: { v(config._envskip, weak: true) },
  bottomdeco: { v(config._envskip, weak: true) },
  frame,
  heading,
  title,
  body,
  label: none,
  numbered: true,
) = [
  #import "html.typ"
  #_env_state.update(it => it + (str(kind): it.at(kind, default: 0) + 1))

  #let i18n = config.i18n.at(kind)
  #let (name, supplement) = if type(i18n) == dictionary {
    (i18n.name, i18n.supplement)
  } else if type(i18n) == str {
    (i18n, i18n)
  } else { panic("Invalid i18n entry for kind: " + kind) }
  #show h: it => html.span(html.div(style: "display: inline-block; width:" + repr(it.amount)))

  #context {
    let num = _env_state.get().at(kind)
    let id = if label != none { (id: str(label)) }

    html.div(
      class: "environment environment-" + kind,
      ..id,
      [
        #html.div(
          class: "environment-header",
          heading(if numbered {
            let num_display = context [#_env_state.get().at(kind)]
            name + h(.25em) + num_display + h(.5em) + title
          } else {
            name + h(.5em) + title
          }),
        )
        #html.div(
          class: "environment-body",
          body,
        )
      ],
    )
  }
]

#let environment = if "target" in sys.inputs and sys.inputs.target == "html" {
  html_environment
} else {
  paged_environment
}

#let remark(..args) = environment(
  "remark",
  red-frame,
  red-frame-heading(),
  none,
  ..args,
)

#let example(title: none, ..args) = environment(
  "example",
  solid-frame,
  example-heading,
  bottomdeco: example-bottomdeco(),
  topdeco: { v(config._envskip, weak: true) },
  title,
  ..args,
)

#let proposition(title: none, body, ..args) = environment(
  "proposition",
  accent-frame,
  accent-frame-heading,
  if title != none { [: #title] + h(1fr) },
  body,
  ..args,
)

#let highlighteq(body) = {
  $
    #box(stroke: config._color_palette.grey, inset: 1em, body)
  $
}

#let definition(title: none, body, ..args) = environment(
  "definition",
  accent-frame,
  accent-frame-heading,
  if title != none { [: #title] + h(1fr) },
  body,
  ..args,
)

#let proof(title: none, body) = {
  let title = if title != none [(#title)]
  let qed_symbol = text(config._color_palette.accent, config._qed_symbol)
  let _body = {
    title + body + h(1fr) + qed_symbol
  }
  if "children" in body.fields() {
    let children = body.children
    let last = children.pop()
    if last.func() == math.equation {
      let with_qed = grid(
        columns: (1fr, auto, 1fr),
        none, last, align(right + horizon, qed_symbol),
      )
     
      children.push(with_qed)
      _body = [].func()(title + children)
    }
  }
  environment(
    numbered: false,
    "proof",
    plain-frame,
    plain-frame-heading,
    none,
    _body,
  )
}
