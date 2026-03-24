
#import "../utils/style.typ": 字号, 字体
#import "../layouts/preface.typ": preface-heading-above, preface-heading-below

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

      // 使用 Typst 官方推荐的 block 方式控制标题间距
      #show heading.where(level: 1, numbering: none): set block(
        above: preface-heading-above,
        below: preface-heading-below,
      )

      #heading(level: 1, numbering: none, outlined: outlined, title) <no-auto-pagebreak>

      #body
    ]
  }
}
