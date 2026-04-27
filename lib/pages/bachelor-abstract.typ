#import "../utils/style.typ": 字号, 字体

// 西北工业大学本科生中文摘要页
#let bachelor-abstract(
  fonts: (:),
  keywords: (),
  outline-title: "摘 要",
  outlined: false,
  body,
) = {
  fonts = 字体 + fonts

  heading(level: 1, outlined: outlined, outline-title)
  body

  v(1em)
  [
    #set par(first-line-indent: 0pt)
    #text(font: fonts.宋体, size: 字号.小四)[
      #text(font: fonts.黑体, weight: "regular")[关键词]：#(("",)+ keywords.intersperse("，")).sum()
    ]
  ]
}
