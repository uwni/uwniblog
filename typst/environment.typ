#let _env_state = state("env", (:))

#let _reset_env_counting() = _env_state.update(it => it.keys().map(k => (k, 0)).to-dict())

#let _color_palette = (
  accent: luma(25%),
  grey: rgb(100, 100, 100),
  grey-light: rgb(224, 228, 228),
)

#let en-config = (
  _sans_font: "Barlow",
  _main_size: 1em,
  _page_num_size: 1em,
  _qed-symbol: sym.qed,
  _envskip: 1em,
  title-wrapper: ("(", ")"),
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
)

#let lzh-config = (
  _sans_font: "Barlow",
  _main_size: 1em,
  _page_num_size: 1em,
  _qed-symbol: sym.qed,
  _envskip: 1em,
  title-wrapper: ("（", "）"),
  i18n: (
    chapter: "章",
    section: "節",
    appendix: "附錄",
    proof: (name: "證.", supplement: "證"),
    proposition: (name: "命題", supplement: "命題"),
    axiom: (name: "公理", supplement: "公理"),
    example: (name: "例", supplement: "例"),
    definition: (name: "定義", supplement: "定義"),
    bibliography: "参考文献",
    index: "索引",
    toc: "目录",
  ),
)

#let use-context(fn) = context {
  let lang = text.lang
  let config = if lang == "lzh" { lzh-config } else { en-config }
  let counter = _env_state.get()
  let ctx = (
    config: config,
    counter: counter,
  )
  fn(ctx)
}

#let paged-environment(
  kind: none,
  title: none,
  body,
  render: none,
  label: none,
  numbered: true,
) = [
  #_env_state.update(it => it + (str(kind): it.at(kind, default: 0) + 1))
  #show figure.where(kind: kind): set block(breakable: true)
  #show figure.where(kind: kind): it => it.body

  #use-context(ctx => [
    #let i18n = ctx.config.i18n.at(kind)

    #let (name, supplement) = if type(i18n) == dictionary {
      (i18n.name, i18n.supplement)
    } else if type(i18n) == str {
      (i18n, i18n)
    } else { panic("Invalid i18n entry for kind: " + kind) }
    #let number = if numbered [#ctx.counter.at(kind)]

    #figure(kind: kind, supplement: supplement, placement: none, caption: none, {
      set align(left)
      render(number: number, name, title, body)
    }) #label
  ])
]

#let html-environment(
  // config
  kind: none,
  frame-class: none,
  label: none,
  compact: false,
  // data
  title: none,
  numbered: true,
  render: none,
  body,
) = [
  #import "html.typ"
  #_env_state.update(it => it + (str(kind): it.at(kind, default: 0) + 1))

  #use-context(ctx => {
    let i18n = ctx.config.i18n.at(kind)
    let (name, supplement) = if type(i18n) == dictionary {
      (i18n.name, i18n.supplement)
    } else if type(i18n) == str {
      (i18n, i18n)
    } else { panic("Invalid i18n entry for kind: " + kind) }

    let id = if label != none { (id: str(label)) }
    let number = if numbered { _env_state.get().at(kind) }
    let (heading, body) = render(number: number, name, title, body)
    html.div(
      class: "environment envframe-" + frame-class + " envkind-" + kind,
      ..id,
      [
        #html.div(
          class: "environment-header" + if title == none { " inlined" },
          heading,
        )
        #html.div(
          class: "environment-body",
          body,
        )
      ],
    )
  })
]

#let environment(
  kind: "",
  frame-class: none,
  compact: false,
  numbered: true,
  label: none,
  html-render: (number: none, name, title, body) => {
    panic("No render function provided when rendering HTML: ", title)
  },
  paged-render: (number: none, name, title, body) => {
    panic("No render function provided when paged rendering: ", title)
  },
) = (..args) => if "target" in sys.inputs and sys.inputs.target == "html" {
  html-environment(
    kind: kind,
    label: label,
    compact: compact,
    frame-class: frame-class,
    numbered: numbered,
    render: html-render,
    ..args,
  )
} else {
  paged-environment(
    kind: kind,
    label: label,
    numbered: numbered,
    render: paged-render,
    ..args,
  )
}

#let accent-render-html(number: none, name, title, body) = {
  import "html.typ"

  (
    heading: use-context(ctx => [
      #html.div(class: "environment-kind")[#name #number\. ]
      #if title != none [
        #let (wrapper-left, wrapper-right) = ctx.config.title-wrapper
        #html.div(class: "environment-title")[#wrapper-left#title#wrapper-right]
      ]
    ]),
    body: body,
  )
}

#let accent-render(number: none, name, title, body) = {
  let heading = use-context(ctx => {
    let kind-text = text.with(
      font: ctx.config._sans_font,
      weight: 500,
      // tracking: 0.02em,
      size: ctx.config._main_size,
    )

    let (title, heading-container) = if title != none {
      let (wrapper-left, wrapper-right) = ctx.config.title-wrapper
      ([#wrapper-left#title#wrapper-right], block.with(sticky: true))
    } else {
      (none, box)
    }

    let heading = if number != none {
      // set text(fill: _color_palette.grey)
      kind-text(name + h(.25em) + number) + h(.5em) + title
    } else {
      kind-text(name) + h(.5em) + title
    }

    heading-container(heading)
  })

  block(
    breakable: true,
    fill: _color_palette.grey-light,
    width: 100%,
    outset: 0pt,
    inset: 1em,
    heading + body,
  )
}

#let solid-frame = (
  stroke: (left: (thickness: .25em, paint: _color_palette.accent)),
  width: 100%,
  outset: (bottom: 1pt, top: 0.5pt),
  inset: 1em,
  breakable: true,
)


#let example-render(number: none, name, title, body) = {
  let heading = use-context(ctx => {
    set text(
      font: ctx.config._sans_font,
      weight: 500,
      // tracking: 0.07em,
      size: ctx.config._main_size,
    )

    let title = if title != none {
      let (wrapper-left, wrapper-right) = ctx.config.title-wrapper
      [#wrapper-left#title#wrapper-right]
    }

    block(
      [#name #number #h(.5em) #title],
      spacing: 1em,
      sticky: true,
      stroke: (top: gradient.linear(..(25%, 50%, 75%).map(luma)).sharp(3)),
      outset: (x: 1em, top: 1em),
    )
  })

  let example-bottomdeco = use-context(ctx => {
    block(height: 1pt, width: 1em, fill: _color_palette.accent, outset: 0pt, above: 0pt, breakable: false)
    v(ctx.config._envskip, weak: true)
  })

  [
    #block(
      breakable: true,
      ..solid-frame,
      heading + body,
    )
    #example-bottomdeco
  ]
}

#let example-render-html(number: none, name, title, body) = {
  import "html.typ"

  (
    heading: use-context(ctx => [
      #html.div(class: "environment-kind")[#name #number\. ]
      #if title != none [
        #let (wrapper-left, wrapper-right) = ctx.config.title-wrapper
        #html.div(class: "environment-title")[#wrapper-left#title#wrapper-right]
      ]
    ]),
    body: body,
  )
}

#let example = environment(
  kind: "example",
  paged-render: example-render,
  html-render: example-render-html,
)

#let proposition = environment(
  kind: "proposition",
  frame-class: "accent",
  paged-render: accent-render,
  html-render: accent-render-html,
)

#let axiom = environment(
  kind: "axiom",
  frame-class: "accent",
  paged-render: accent-render,
  html-render: accent-render-html,
  compact: true,
)


#let highlighteq(body) = {
  $
    #box(stroke: _color_palette.grey, inset: 1em, body)
  $
}

#let definition = environment(
  kind: "definition",
  frame-class: "accent",
  paged-render: accent-render,
  html-render: accent-render-html,
  compact: true,
)

#let plain-frame-heading(number: none, name, title) = {
  text(style: "italic", name) + if title != none [(#title)]
}


#let proof = {
  let qed-symbol = use-context(ctx => ctx.config._qed-symbol)

  let proof-paged-render(number: none, name, title, body) = {
    block(
      breakable: true,
      width: 100%,
      plain-frame-heading(number: number, name, title) + body + h(1fr) + qed-symbol,
    )
  }

  let proof-html-render(number: none, name, title, body) = {
    import "html.typ"

    let heading = html.span(name, style: "font-style: italic;") + if title != none [(#title)]
    let qed-symbol = html.span(qed-symbol, style: "float: right;")
    let body = body + qed-symbol
    (heading: heading, body: body)
  }


  environment(
    numbered: false,
    kind: "proof",
    frame-class: "plain",
    html-render: proof-html-render,
    paged-render: proof-paged-render,
  )
}
