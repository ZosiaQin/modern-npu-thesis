#import "../utils/style.typ": 字体, 字号
#import "../layouts/preface.typ": preface-heading-above, preface-heading-below

// 西北工业大学研究生学术成果页
#let academic-achievements(
  // documentclass 传入参数
  anonymous: false,
  twoside: false,
  fonts: (:),
  // 其他参数
  title: "在学期间取得的学术成果和参加科研情况",
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
    if twoside {
      pagebreak(weak: true, to: "odd")
    }
  }
}
