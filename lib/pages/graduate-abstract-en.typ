#import "../utils/style.typ": 字号, 字体
#import "../format.typ": body-format

#let master-abstract-en(
  fonts: (:),
  keywords: (),
  outline-title: "Abstract",
  outlined: true,
  keywords-above: body-format.graduate.keywords-above,
  funding: none,
  body,
) = {
  fonts = 字体 + fonts

  // 英文摘要标题覆盖字体为 Times New Roman，其余由 mainmatter 处理
  show heading.where(level: 1): it => {
    set text(font: "Times New Roman", weight: "bold")
    it
  }

  [
    #metadata(none) <__nwpu_master_abstract_en_heading_start__>
    #heading(level: 1, outlined: outlined, outline-title)
    #metadata(none) <__nwpu_master_abstract_en_heading_end__>
  ]

  [
    #set text(font: "Times New Roman")
    #body
  ]

  [
    #set par(first-line-indent: 0pt)
    #v(keywords-above)
    #text(font: "Times New Roman")[
      #strong[Key words]#text(font: fonts.黑体, weight: "bold")[：]#(("",) + keywords.intersperse("; ")).sum()
    ]
  ]

  v(1fr)

  if funding != none [
    #set par(leading: 1.4em)
    #text(font: fonts.宋体, size: 字号.五号)[#funding]
  ]
}
