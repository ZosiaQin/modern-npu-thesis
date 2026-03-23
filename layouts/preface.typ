// 前言，重置页面计数器
#let preface(
  // documentclass 传入的参数
  twoside: false,
  ..args,
  it,
) = {
  // 双面打印时确保从奇数页开始
  pagebreak(weak: true, to: if twoside { "odd" })
  counter(page).update(0)
  set page(numbering: "I")
  it
}