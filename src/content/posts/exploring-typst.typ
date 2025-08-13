#import "/_typst/helper.typ": post-template

#show: post-template.with(
  title: "Exploring Typst: A Modern Alternative to LaTeX",
  tags: ("typst", "technology", "writing"),
)

Recently, I've been diving into #link("https://typst.app/")[Typst], a new markup-based typesetting system that promises to be a modern alternative to LaTeX. As someone who's wrestled with LaTeX's quirks for years, I was immediately intrigued.

== What Makes Typst Special?

=== Lightning Fast Compilation
Unlike LaTeX, which can take ages to compile complex documents, Typst compiles almost instantly. This makes the writing experience much more fluid and interactive.

=== Clean, Intuitive Syntax
Compare this LaTeX:
```latex
\documentclass{article}
\usepackage{amsmath}
\begin{document}
\section{My Section}
\begin{equation}
  \sum_{i=1}^{n} i = \frac{n(n+1)}{2}
\end{equation}
\end{document}
```

With this Typst:
```typst
= My Section

$ sum_(i=1)^n i = (n(n+1))/2 $
```

Much cleaner, right?

=== Built-in Programming Language
Typst includes a powerful scripting language that makes it easy to:
- Generate content programmatically
- Create reusable templates
- Handle complex layouts without hacks

== My Experience So Far

I've been using Typst for:
- *Technical documentation*: The math support is excellent
- *Blog posts*: Like this one! The integration with Eleventy is seamless
- *Academic papers*: Still experimenting, but promising

The learning curve is much gentler than LaTeX, and the documentation is actually readable (revolutionary concept, I know).

== Challenges

Not everything is perfect:
- *Ecosystem*: Still smaller than LaTeX's massive package ecosystem
- *Advanced features*: Some specialized formatting still requires workarounds
- *Export options*: PDF is great, but HTML output could be better

== Verdict

For new projects, I'm definitely choosing Typst over LaTeX. The speed and simplicity wins make up for the smaller ecosystem. Plus, it's actively developed and improving rapidly.

Have you tried Typst? I'd love to hear about your experiences!