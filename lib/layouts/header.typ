#import "../deps.typ": zh

// ============================================
// 页眉统一配置
// ============================================

// 页码渲染函数
#let page-footer(fmt) = context align(center)[
  #set text(size: zh(5.5))
  #counter(page).display(fmt)
]

// 研究生页眉渲染函数
#let header-render(content) = {
  [
    #set par(leading: 0pt, spacing: 0pt)
    #set text(size: zh(5.5))
    #align(center)[#content]
    #v(0.5em)
    #line(length: 100%, stroke: 3.2pt + black)
    #v(0.32em)
    #line(length: 100%, stroke: 0.6pt + black)
  ]
}

#let graduate-header-title(degree) = {
  if degree == "doctor" {
    "西北工业大学博士学位论文"
  } else {
    "西北工业大学硕士学位论文"
  }
}

#let bachelor-header-render() = {
  [
    #set par(spacing: 4pt, first-line-indent: (amount: 6.1em, all: true))
    #set text(size: zh(3), weight: "bold")
    #box(width: 2.99cm, height: 0.61cm, move(dy: 0.1em, image("../assets/nwpu-name.png")))#h(0.2em)本科毕业设计（论文）
    #line(length: 100%, stroke: 0.8pt + black)
  ]
}
