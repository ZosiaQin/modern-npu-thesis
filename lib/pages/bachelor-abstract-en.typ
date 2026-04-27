#import "../utils/style.typ": 字号, 字体

// 西北工业大学本科生英文摘要页
#let bachelor-abstract-en(
  fonts: (:),
  keywords: (),
  outline-title: "ABSTRACT",
  outlined: false,
  body,
) = {
  fonts = 字体 + fonts

  // 英文摘要标题覆盖字体为 Times New Roman，其余由 mainmatter 处理
  show heading.where(level: 1): it => {
    set text(font: "Times New Roman")
    it
  }

  heading(level: 1, outlined: outlined, outline-title)

  [
    #set text(font: "Times New Roman")
    #body
  ]

  v(1em)
  [
    #set par(first-line-indent: 0pt)
    #text(font: "Times New Roman", size: 字号.小四)[
      #text(weight: "bold")[KEY WORDS]#text(font: fonts.宋体)[：]#(("",)+ keywords.intersperse(", ")).sum()
    ]
  ]
}
