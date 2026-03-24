
#import "../utils/style.typ": 字号, 字体
#import "../layouts/preface.typ": preface-heading-above, preface-heading-below, preface-heading-font, preface-heading-size, preface-heading-weight

// 致谢页
#let acknowledgement(
  // documentclass 传入参数
  anonymous: false,
  twoside: false,
  doctype: "master",
  fonts: (:),
  // 其他参数
  title: "致　谢",
  outlined: true,
  body,
) = {
  fonts = 字体 + fonts

  if not anonymous {
    pagebreak(weak: true, to: if twoside { "odd" })
    [
      #set text(font: fonts.宋体, size: 字号.小四)
      #set par(leading: 1.5em, justify: true)

      // 使用统一的一级标题样式配置
      #show heading.where(level: 1, numbering: none): it => {
        set align(center)
        set text(font: preface-heading-font(fonts), size: preface-heading-size, weight: preface-heading-weight)
        set block(above: preface-heading-above, below: preface-heading-below)
        it.body
      }

      #heading(level: 1, numbering: none, outlined: outlined, title) <no-auto-pagebreak>

      #body
    ]
  }
}
