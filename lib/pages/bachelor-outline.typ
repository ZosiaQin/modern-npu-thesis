#import "../utils/style.typ": 字体, 字号
#import "../format.typ": body-format, heading-format

// 本科生目录页
#let bachelor-outline(
  // documentclass 传入参数
  english-writing: false,
  fonts: (:),
  // 其他参数
  depth: 3,
  title: auto,
  outlined: false,
  title-vspace: 0pt,
  title-text-args: auto,
  // 引用页数的字体
  reference-font: auto,
  reference-size: auto,
  // 目录字体与字号
  font: auto,
  size: auto,
  indent: (0pt, 24pt, 18pt),
  weight: auto,
  // 默认引导符
  fill: auto,
  gap: .3em,
  // 行间距
  leading: auto,
) = {
  fonts = 字体 + fonts

  let chinese_chapter_number(n) = {
    let digits = ("零", "一", "二", "三", "四", "五", "六", "七", "八", "九")
    if n <= 10 {
      if n == 10 { "十" } else { digits.at(n) }
    } else if n < 20 {
      "十" + digits.at(calc.rem(n, 10))
    } else if calc.rem(n, 10) == 0 {
      digits.at(calc.floor(n / 10)) + "十"
    } else {
      digits.at(calc.floor(n / 10)) + "十" + digits.at(calc.rem(n, 10))
    }
  }

  // 标题默认值
  if title == auto {
    title = if english-writing { "Contents" } else { "目 录" }
  }
  if title-text-args == auto {
    title-text-args = (font: fonts.黑体, size: 字号.三号, weight: "bold")
  }
  // 引用页数字体
  if reference-font == auto {
    reference-font = fonts.宋体
  }
  if reference-size == auto {
    reference-size = 字号.小四
  }
  // 目录字体与字号
  if font == auto {
    font = (fonts.宋体, fonts.宋体)
  }
  if size == auto {
    size = (字号.小四, 字号.小四)
  }
  if weight == auto {
    weight = ("bold", "regular", "regular")
  }
  if fill == auto {
    fill = (repeat([#move(dy: -0.1em, text(size: 0.4em)[·])], gap: -0.1em),)
  }
  // 行间距
  if leading == auto {
    leading = body-format.bachelor.leading
  }

  set text(font: reference-font, size: reference-size)

  [
    // 目录标题
    #show heading.where(level: 1, numbering: none): it => {
      set text(..title-text-args)
      it
    }
    #heading(level: 1, outlined: outlined, title)

    #v(title-vspace)

    // 目录样式
    #set par(leading: leading, spacing: 0pt)
    #set outline(indent: level => indent.slice(0, calc.min(level + 1, indent.len())).sum())
    #show outline.entry: entry => {
      let in-mainmatter-or-later = query(
        selector(label("__nwpu_mainmatter_start__")).before(entry.element.location()),
      ).len() > 0
      let entry-page-number = counter(page).at(entry.element.location()).first()
      let entry-page-display = text(font: reference-font, size: reference-size)[#numbering("1", entry-page-number)]
      let is-appendix-entry = (
        query(selector(label("appendix-start")).before(entry.element.location())).len()
        > query(selector(label("appendix-end")).before(entry.element.location())).len()
      )
      let prefix = if entry.level == 1 and entry.prefix() not in (none, []) and not is-appendix-entry {
        let nums = counter(heading).at(entry.element.location())
        [第#chinese_chapter_number(nums.first())章 ]
      } else {
        entry.prefix()
      }
      let prefix-gap = if is-appendix-entry and entry.level == 1 {
        0pt
      } else {
        gap
      }
      let entry-content = link(
        entry.element.location(),
        entry.indented(
          none,
          {
            text(
              font: font.at(entry.level - 1, default: font.last()),
              size: size.at(entry.level - 1, default: size.last()),
              weight: weight.at(entry.level - 1, default: weight.last()),
              {
                if prefix not in (none, []) {
                  prefix
                  h(prefix-gap)
                }
                entry.body()
              },
            )
            box(width: 1fr, inset: (x: .25em), fill.at(entry.level - 1, default: fill.last()))
            entry-page-display
          },
          gap: 0pt,
        ),
      )
      block(
        above: if entry.level == 1 { 1.5em } else { 1em },
        below: 0.1em,
        entry-content,
      )
    }

    // 显示目录
    #outline(title: none, depth: depth)
  ]
}
