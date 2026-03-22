#let 字号 = (
  初号: 42pt,
  小初: 36pt,
  一号: 26pt,
  小一: 24pt,
  二号: 22pt,
  小二: 18pt,
  三号: 16pt,
  小三: 15pt,
  四号: 14pt,
  中四: 13pt,
  小四: 12pt,
  五号: 10.5pt,
  小五: 9pt,
  六号: 7.5pt,
  小六: 6.5pt,
  七号: 5.5pt,
  小七: 5pt,
)

#let 字体 = (
  // 宋体 - 使用系统已有的字体
  // Noto Serif CJK SC 是思源宋体简体，NSimSun 是新宋体
  宋体: ("Noto Serif CJK SC", "NSimSun", "CESI_SS_GB18030", "SimSun", "Songti SC"),

  // 黑体 - 使用系统已有的字体
  // STXihei 是华文细黑，Noto Sans CJK SC 是思源黑体简体
  黑体: ("Noto Sans CJK SC", "STXihei", "SimHei", "Heiti SC", "STHeiti"),

  // 楷体 - STKaiti 是华文楷体
  楷体: ("STKaiti", "CESI_KT_GB18030", "KaiTi", "Kaiti SC"),

  // 仿宋
  仿宋: ("FangSong", "STFangSong"),

  // 等宽字体 - 用于代码块
  等宽: ("Noto Sans Mono CJK SC", "Source Han Sans HW SC", "SimHei"),
)