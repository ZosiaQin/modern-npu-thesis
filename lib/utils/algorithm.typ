#import "../deps.typ": algo-render
#import "style.typ": 字号
#import "custom-numbering.typ": numbering-format

#let algorithm-figure = figure.where(kind: "algorithm")
#let english-writing-state = state("nwpu-english-writing", false)

#let localized-term(chinese, english) = context {
  if english-writing-state.get() {
    [#english]
  } else {
    [#chinese]
  }
}

#let with-english-writing(enabled, it) = {
  english-writing-state.update(enabled)
  it
}

// 算法编号：从 numbering-format 状态读取格式，附录自动切换
#let algorithm-numbering(number) = context {
  numbering(numbering-format.get(), counter(heading).at(here()).first(), number)
}

#let algorithm(title: none, ..body) = {
  figure(
    kind: "algorithm",
    supplement: localized-term("算法", "Algorithm"),
    numbering: algorithm-numbering,
    caption: title,
    outlined: false,
    {
      set text(size: 字号.五号)
      algo-render(
        line-numbers: true,
        line-numbers-format: x => [#x],
        inset: 0.43em,
        vstroke: none,
        ..body,
      )
    },
  )
}
