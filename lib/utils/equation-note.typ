#import "../utils/style.typ": 字号
#import "../utils/algorithm.typ": english-writing-state

#let equation-note(body) = context {
  block(width: 100%)[
    #set par(first-line-indent: 0pt, justify: false)
    #set text(size: 字号.五号)
    #if english-writing-state.get() {
      [where ]
    } else {
      [式中，]
    }
    #body
  ]
}
