#import "../utils/style.typ": 字号, 字体
#import "../format.typ": body-format

#let master-abstract(
  fonts: (:),
  keywords: (),
  outline-title: "摘　要",
  outlined: true,
  keywords-above: body-format.graduate.keywords-above,
  funding: none,
  body,
) = {
  fonts = 字体 + fonts

  heading(level: 1, outlined: outlined, outline-title)
  body

  [
    #set par(first-line-indent: 0pt)
    #v(keywords-above)
    #h(2em)#text(font: fonts.黑体)[关键词：]#text(font: fonts.宋体)[#(("",) + keywords.intersperse("；")).sum()]
  ]

  v(1fr)

  if funding != none [
    #set par(leading: 1.4em)
    #text(font: fonts.宋体, size: 字号.五号)[#funding]
  ]
}
