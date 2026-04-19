#import "@preview/gb7714-bilingual:0.2.3": gb7714-bibliography
#import "../utils/style.typ": 字体, 字号
#import "../layouts/preface.typ": preface-heading-style, preface-heading-above, preface-heading-below, preface-heading-leading, preface-body-leading, preface-body-spacing, preface-body-first-line-indent

#let bilingual-bibliography(
  bibliography: none,
  doctype: "master",
  twoside: false,
  english-writing: false,
  fonts: (:),
  leading: auto,
  spacing: auto,
  title: auto,
  title-leading: auto,
  title-above: auto,
  title-below: auto,
  full: false,
  style: "gb-7714-2015-numeric",
  label-shift: 2.1em,
  label-gap: 0.5em,
  content-shift: -0.85em,
  content-hanging-indent: -4.3em,
  single-digit-content-hanging-indent: auto,
  double-digit-content-hanging-indent: -4.8em,
  triple-digit-content-hanging-indent: -5.2em,
  mapping: (:),
  extra-comma-before-et-al-trans: false,
  allow-comma-in-name: false,
) = {
  fonts = 字体 + fonts
  let is-graduate = doctype == "master" or doctype == "doctor"
  if title == auto {
    title = if english-writing { "References" } else { "参考文献" }
  }
  if title-leading == auto {
    title-leading = preface-heading-leading
  }
  if title-above == auto {
    title-above = if is-graduate { preface-heading-above } else { 0pt }
  }
  if title-below == auto {
    title-below = if is-graduate { preface-heading-below } else { 0pt }
  }
  if leading == auto {
    leading = if is-graduate { preface-body-leading } else { auto }
  }
  if spacing == auto {
    spacing = if is-graduate { preface-body-spacing } else { auto }
  }

  pagebreak(weak: true, to: if twoside { "odd" })

  set text(lang: "zh")
  set par(first-line-indent: preface-body-first-line-indent)

  if is-graduate {
    set text(font: fonts.宋体, size: 字号.小四)
    set par(leading: leading, spacing: spacing, justify: true, first-line-indent: preface-body-first-line-indent)
    show heading.where(level: 1, numbering: none): it => preface-heading-style(
      it,
      fonts,
      leading: title-leading,
      above: 0pt,
      below: title-below,
    )
    v(title-above)
    heading(level: 1, numbering: none, outlined: true)[#title]
  } else if title != none {
    heading(level: 1, numbering: none, outlined: true)[#title]
  }

  gb7714-bibliography(title: none, full: full)
}
