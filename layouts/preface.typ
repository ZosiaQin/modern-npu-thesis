#import "../utils/style.typ": 字体, 字号
#import "../utils/header.typ": graduate-header-title, header-render
#import "../utils/custom-heading.typ": active-heading, heading-display

// 前置部分一级标题间距配置（摘要、目录、致谢等页面使用）
// 使用 Typst 官方推荐的 block 方式控制间距
#let preface-heading-above = 2 * 15.6pt - 0.7em  // 约 31pt
#let preface-heading-below = 2 * 15.6pt - 0.7em  // 约 31pt

// 前置部分一级标题样式
// 注意：此样式仅对前置部分（摘要、目录等）生效，正文部分由 mainmatter.typ 控制
#let preface-heading-style(it, fonts, center: true) = {
  set text(font: fonts.黑体, size: 字号.三号)
  set block(above: preface-heading-above, below: preface-heading-below)
  if center {
    set align(center)
  }
  it.body
}

// 前言
#let preface(
  twoside: false,
  doctype: "master",
  fonts: (:),
  display-header: true,
  ..args,
  it,
) = {
  fonts = 字体 + fonts

  // 1. 设置页码逻辑
  // 注意：pagebreak 放在 set page 之前
  pagebreak(weak: true, to: if twoside { "odd" })
  counter(page).update(1)

  // 2. 页面全局设置
  set page(
    footer: context align(center)[
      #set text(size: 字号.小五)
      #counter(page).display("I")
    ],
  )

  // 3. 页眉设置
  // 我们直接在这里针对 it 应用 show rule，或者直接 set page
  show: it => {
    set page(
      header: context {
        if not display-header { return none }

        let loc = here()
        let is-graduate = (doctype == "master" or doctype == "doctor")

        // 默认显示当前章节
        let header-content = heading-display(active-heading(level: 1, prev: false))

        // 双面模式下的偶数页替换为校名
        if twoside and calc.rem(loc.page(), 2) == 0 and is-graduate {
          header-content = graduate-header-title(doctype)
        }

        if is-graduate {
          header-render(header-content, fonts: fonts)
        }
      }
    )
    it
  }

  // 4. 统一控制前置部分一级标题的间距
  // 使用 Typst 官方推荐的 block 方式，避免手动 v() 间距
  show heading.where(level: 1, numbering: none): set block(
    above: preface-heading-above,
    below: preface-heading-below,
  )

  it
}
