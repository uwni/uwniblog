#import html: elem

// Main root
#let html(..args) = elem("html", attrs: args.named(), ..args.pos())

// Document metadata
#let base(..artoggle_panelgs) = elem("base", attrs: args.named(), ..args.pos())
#let head(..args) = elem("head", attrs: args.named(), ..args.pos())
#let link(..args) = elem("link", attrs: args.named(), ..args.pos())
#let meta(..args) = elem("meta", attrs: args.named(), ..args.pos())
#let style(..args) = elem("style", attrs: args.named(), ..args.pos())
#let title(..args) = elem("title", attrs: args.named(), ..args.pos())

// Sectioning root
#let body(..args) = elem("body", attrs: args.named(), ..args.pos())

// Content sectioning
#let address(..args) = elem("address", attrs: args.named(), ..args.pos())
#let article(..args) = elem("article", attrs: args.named(), ..args.pos())
#let aside(..args) = elem("aside", attrs: args.named(), ..args.pos())
#let footer(..args) = elem("footer", attrs: args.named(), ..args.pos())
#let header(..args) = elem("header", attrs: args.named(), ..args.pos())
#let h1(..args) = elem("h1", attrs: args.named(), ..args.pos())
#let h2(..args) = elem("h2", attrs: args.named(), ..args.pos())
#let h3(..args) = elem("h3", attrs: args.named(), ..args.pos())
#let h4(..args) = elem("h4", attrs: args.named(), ..args.pos())
#let h5(..args) = elem("h5", attrs: args.named(), ..args.pos())
#let h6(..args) = elem("h6", attrs: args.named(), ..args.pos())
#let hgroup(..args) = elem("hgroup", attrs: args.named(), ..args.pos())
#let main(..args) = elem("main", attrs: args.named(), ..args.pos())
#let nav(..args) = elem("nav", attrs: args.named(), ..args.pos())
#let section(..args) = elem("section", attrs: args.named(), ..args.pos())
#let search(..args) = elem("search", attrs: args.named(), ..args.pos())

// Text content
#let blockquote(..args) = elem("blockquote", attrs: args.named(), ..args.pos())
#let dd(..args) = elem("dd", attrs: args.named(), ..args.pos())
#let div(..args) = elem("div", attrs: args.named(), ..args.pos())
#let dl(..args) = elem("dl", attrs: args.named(), ..args.pos())
#let dt(..args) = elem("dt", attrs: args.named(), ..args.pos())
#let figcaption(..args) = elem("figcaption", attrs: args.named(), ..args.pos())
#let figure(..args) = elem("figure", attrs: args.named(), ..args.pos())
#let hr(..args) = elem("hr", attrs: args.named(), ..args.pos())
#let li(..args) = elem("li", attrs: args.named(), ..args.pos())
#let menu(..args) = elem("menu", attrs: args.named(), ..args.pos())
#let ol(..args) = elem("ol", attrs: args.named(), ..args.pos())
#let p(..args) = elem("p", attrs: args.named(), ..args.pos())
#let pre(..args) = elem("pre", attrs: args.named(), ..args.pos())
#let ul(..args) = elem("ul", attrs: args.named(), ..args.pos())

// Inline text semantics
#let a(..args) = elem("a", attrs: args.named(), ..args.pos())
#let abbr(..args) = elem("abbr", attrs: args.named(), ..args.pos())
#let b(..args) = elem("b", attrs: args.named(), ..args.pos())
#let bdi(..args) = elem("bdi", attrs: args.named(), ..args.pos())
#let bdo(..args) = elem("bdo", attrs: args.named(), ..args.pos())
#let br(..args) = elem("br", attrs: args.named(), ..args.pos())
#let cite(..args) = elem("cite", attrs: args.named(), ..args.pos())
#let code(..args) = elem("code", attrs: args.named(), ..args.pos())
#let data(..args) = elem("data", attrs: args.named(), ..args.pos())
#let dfn(..args) = elem("dfn", attrs: args.named(), ..args.pos())
#let em(..args) = elem("em", attrs: args.named(), ..args.pos())
#let i(..args) = elem("i", attrs: args.named(), ..args.pos())
#let kbd(..args) = elem("kbd", attrs: args.named(), ..args.pos())
#let mark(..args) = elem("mark", attrs: args.named(), ..args.pos())
#let q(..args) = elem("q", attrs: args.named(), ..args.pos())
#let rp(..args) = elem("rp", attrs: args.named(), ..args.pos())
#let rt(..args) = elem("rt", attrs: args.named(), ..args.pos())
#let ruby(..args) = elem("ruby", attrs: args.named(), ..args.pos())
#let s(..args) = elem("s", attrs: args.named(), ..args.pos())
#let samp(..args) = elem("samp", attrs: args.named(), ..args.pos())
#let small(..args) = elem("small", attrs: args.named(), ..args.pos())
#let span(..args) = elem("span", attrs: args.named(), ..args.pos())
#let strong(..args) = elem("strong", attrs: args.named(), ..args.pos())
#let sub(..args) = elem("sub", attrs: args.named(), ..args.pos())
#let sup(..args) = elem("sup", attrs: args.named(), ..args.pos())
#let time(..args) = elem("time", attrs: args.named(), ..args.pos())
#let u(..args) = elem("u", attrs: args.named(), ..args.pos())
#let var(..args) = elem("var", attrs: args.named(), ..args.pos())
#let wbr(..args) = elem("wbr", attrs: args.named(), ..args.pos())

// Image and multimedia
#let area(..args) = elem("area", attrs: args.named(), ..args.pos())
#let audio(..args) = elem("audio", attrs: args.named(), ..args.pos())
#let img(..args) = elem("img", attrs: args.named(), ..args.pos())
#let map(..args) = elem("map", attrs: args.named(), ..args.pos())
#let track(..args) = elem("track", attrs: args.named(), ..args.pos())
#let video(..args) = elem("video", attrs: args.named(), ..args.pos())

// Embedded content
#let embed(..args) = elem("embed", attrs: args.named(), ..args.pos())
#let fencedframe(..args) = elem("fencedframe", attrs: args.named(), ..args.pos())
#let iframe(..args) = elem("iframe", attrs: args.named(), ..args.pos())
#let object(..args) = elem("object", attrs: args.named(), ..args.pos())
#let picture(..args) = elem("picture", attrs: args.named(), ..args.pos())
#let source(..args) = elem("source", attrs: args.named(), ..args.pos())

// SVG and MathML
#let svg(..args) = elem("svg", attrs: args.named(), ..args.pos())
#let math(..args) = elem("math", attrs: args.named(), ..args.pos())

// Scripting
#let canvas(..args) = elem("canvas", attrs: args.named(), ..args.pos())
#let noscript(..args) = elem("noscript", attrs: args.named(), ..args.pos())
#let script(..args) = elem("script", attrs: args.named(), ..args.pos())

// Demarcating edits
#let del(..args) = elem("del", attrs: args.named(), ..args.pos())
#let ins(..args) = elem("ins", attrs: args.named(), ..args.pos())

// Table content
#let caption(..args) = elem("caption", attrs: args.named(), ..args.pos())
#let col(..args) = elem("col", attrs: args.named(), ..args.pos())
#let colgroup(..args) = elem("colgroup", attrs: args.named(), ..args.pos())
#let table(..args) = elem("table", attrs: args.named(), ..args.pos())
#let tbody(..args) = elem("tbody", attrs: args.named(), ..args.pos())
#let td(..args) = elem("td", attrs: args.named(), ..args.pos())
#let tfoot(..args) = elem("tfoot", attrs: args.named(), ..args.pos())
#let th(..args) = elem("th", attrs: args.named(), ..args.pos())
#let thead(..args) = elem("thead", attrs: args.named(), ..args.pos())
#let tr(..args) = elem("tr", attrs: args.named(), ..args.pos())

// Forms
#let button(..args) = elem("button", attrs: args.named(), ..args.pos())
#let datalist(..args) = elem("datalist", attrs: args.named(), ..args.pos())
#let fieldset(..args) = elem("fieldset", attrs: args.named(), ..args.pos())
#let form(..args) = elem("form", attrs: args.named(), ..args.pos())
#let input(..args) = elem("input", attrs: args.named(), ..args.pos())
#let label(..args) = elem("label", attrs: args.named(), ..args.pos())
#let legend(..args) = elem("legend", attrs: args.named(), ..args.pos())
#let meter(..args) = elem("meter", attrs: args.named(), ..args.pos())
#let optgroup(..args) = elem("optgroup", attrs: args.named(), ..args.pos())
#let option(..args) = elem("option", attrs: args.named(), ..args.pos())
#let output(..args) = elem("output", attrs: args.named(), ..args.pos())
#let progress(..args) = elem("progress", attrs: args.named(), ..args.pos())
#let select(..args) = elem("select", attrs: args.named(), ..args.pos())
#let selectedcontent(..args) = elem("selectedcontent", attrs: args.named(), ..args.pos())
#let textarea(..args) = elem("textarea", attrs: args.named(), ..args.pos())

// Interactive elements
#let details(..args) = elem("details", attrs: args.named(), ..args.pos())
#let dialog(..args) = elem("dialog", attrs: args.named(), ..args.pos())
#let summary(..args) = elem("summary", attrs: args.named(), ..args.pos())

// Web Components
#let slot(..args) = elem("slot", attrs: args.named(), ..args.pos())
#let template(..args) = elem("template", attrs: args.named(), ..args.pos())
