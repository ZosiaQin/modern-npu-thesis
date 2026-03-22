#import "../utils/datetime-display.typ": datetime-display, datetime-en-display
#import "../utils/justify-text.typ": justify-text
#import "../utils/style.typ": 字号, 字体

// 西北工业大学研究生封面（硕士/博士）
// 包含：外封（表格形式）、内封（简洁居中）、英文封面、评阅人名单
#let master-cover(
  // documentclass 传入的参数
  doctype: "master",
  degree: "academic",
  nl-cover: false,
  anonymous: false,
  twoside: false,
  fonts: (:),
  info: (:),
  // 其他参数
  stroke-width: 0.5pt,
  min-title-lines: 2,
  min-reviewer-lines: 5,
  info-inset: (x: 0pt, bottom: 0.5pt),
  meta-info-inset: (x: 0pt, bottom: 2pt),
  defence-info-inset: (x: 0pt, bottom: 0pt),
  defence-info-key-width: 110pt,
  defence-info-column-gutter: 2pt,
  defence-info-row-gutter: 12pt,
  anonymous-info-keys: ("student-id", "author", "author-en", "supervisor", "supervisor-en", "supervisor-ii", "supervisor-ii-en", "chairman", "reviewer"),
  datetime-display: datetime-display,
  datetime-en-display: datetime-en-display,
) = {
  // 1.  默认参数
  fonts = 字体 + fonts
  info = (
    title: ("基于 Typst 的", "西北工业大学学位论文"),
    grade: "20XX",
    student-id: "1234567890",
    author: "张三",
    department: "某学院",
    major: "某专业",
    supervisor: ("李四", "教授"),
    submit-date: datetime.today(),
    clc: "",
    udc: "",
  ) + info

  // 2.  对参数进行处理
  // 2.1 如果是字符串，则使用换行符将标题分隔为列表
  if type(info.title) == str {
    info.title = info.title.split("\n")
  }
  if type(info.title-en) == str {
    info.title-en = info.title-en.split("\n")
  }
  // 2.2 根据 min-title-lines 和 min-reviewer-lines 填充标题和评阅人
  info.title = info.title + range(min-title-lines - info.title.len()).map((it) => "　")
  info.reviewer = info.reviewer + range(min-reviewer-lines - info.reviewer.len()).map((it) => "　")
  // 2.3 处理日期
  assert(type(info.submit-date) == datetime, message: "submit-date must be datetime.")
  if type(info.defend-date) == datetime {
    info.defend-date = datetime-display(info.defend-date)
  }
  // 2.4 处理 degree
  if info.degree == auto {
    if doctype == "doctor" {
      info.degree = "工学博士"
    } else {
      info.degree = "工学硕士"
    }
  }

  // 3.  内置辅助函数
  let anonymous-text(key, body) = {
    if anonymous and (key in anonymous-info-keys) {
      "██████████"
    } else {
      body
    }
  }

  let defence-info-key(body) = {
    rect(
      inset: defence-info-inset,
      stroke: none,
      text(font: fonts.宋体, size: 字号.三号, weight: "bold", body),
    )
  }

  let defence-info-value(key, body, no-stroke: false) = {
    set align(center)
    rect(
      width: 100%,
      inset: defence-info-inset,
      stroke: if no-stroke { none } else { (bottom: stroke-width + black) },
      text(
        font: fonts.宋体,
        size: 字号.三号,
        bottom-edge: "descender",
        if anonymous and (key in anonymous-info-keys) {
          "█████"
        } else {
          body
        },
      ),
    )
  }


  // ========================================
  // 第一页 - 外封（表格形式）
  // ========================================
  pagebreak(weak: true, to: if twoside { "odd" })

  // 左上角元信息表格
  align(left)[
    #table(
      columns: (auto, auto),
      stroke: (x: stroke-width, y: stroke-width),
      inset: (x: 8pt, y: 4pt),
      [*学校代码*], [*=* #info.school-code],
      [*分类号*], [*=* #info.clc],
    )
  ]

  h(1fr)

  align(right)[
    #table(
      columns: (auto, auto),
      stroke: (x: stroke-width, y: stroke-width),
      inset: (x: 8pt, y: 4pt),
      [*密级*], [*=* #info.secret-level],
      [*学号*], [*=* #anonymous-text("student-id", info.student-id)],
    )
  ]

  v(40pt)

  // 题目表格
  align(center)[
    #table(
      columns: (auto, 1fr),
      stroke: (x: none, y: stroke-width),
      inset: (x: 8pt, y: 8pt),
      [*题目*], [*#info.title.sum()*],
    )
  ]

  v(20pt)

  // 作者
  align(center)[
    #block(width: 200pt)[
      #table(
        columns: (auto, 1fr),
        stroke: (x: none, y: stroke-width),
        inset: (x: 8pt, y: 8pt),
        [*作者*], [*#anonymous-text("author", info.author)*],
      )
    ]
  ]

  v(60pt)

  // 详细信息表格
  let major-row-label = if degree == "professional" { [*专业领域*] } else { [*学科专业*] }

  align(center)[
    #block(width: 300pt)[
      #table(
        columns: (auto, 1fr),
        stroke: (x: stroke-width, y: stroke-width),
        inset: (x: 8pt, y: 6pt),
        [#major-row-label],
        [#info.major],
        [*指导教师*],
        [#info.supervisor.intersperse(" ").sum()],
        [*培养单位*],
        [#info.department],
        [*申请日期*],
        [#datetime-display(info.submit-date)],
      )
    ]
  ]


  // ========================================
  // 第二页 - 内封（简洁居中形式）
  // ========================================
  pagebreak(weak: true, to: if twoside { "odd" })

  set align(center)

  v(80pt)

  // 校名
  text(size: 字号.一号, font: fonts.宋体, weight: "bold")[西 北 工 业 大 学]

  v(30pt)

  // 学位论文类型
  text(size: 28pt, font: fonts.宋体, spacing: 200%, weight: "bold",
    if doctype == "doctor" { "博 士 学 位 论 文" } else { "硕 士 学 位 论 文" },
  )

  v(60pt)

  // 论文信息（简洁格式）
  set text(font: fonts.宋体, size: 字号.三号)

  let major-label = if degree == "professional" { "专业领域：" } else { "学科专业：" }

  align(left)[
    #grid(
      columns: (80pt, 1fr),
      row-gutter: 15pt,
      [题目：],
      underline(info.title.sum()),
      [#major-label],
      underline(info.major),
      [作者：],
      underline(anonymous-text("author", info.author)),
      [指导教师：],
      underline(info.supervisor.intersperse(" ").sum()),
    )
  ]

  v(80pt)

  // 日期
  text(font: fonts.宋体, size: 字号.三号, datetime-display(info.submit-date))


  // ========================================
  // 第三页 - 英文封面
  // ========================================
  pagebreak(weak: true)

  set text(font: fonts.宋体, size: 字号.小四)
  set par(leading: 1.5em)

  v(45pt)

  text(font: fonts.黑体, size: 字号.二号, weight: "bold", info.title-en.intersperse("\n").sum())

  v(30pt)

  text(size: 字号.四号)[by]

  v(-6pt)

  text(font: fonts.黑体, size: 字号.四号, weight: "bold", anonymous-text("author-en", info.author-en))

  v(11pt)

  text(size: 字号.四号)[Under the Supervision of Professor]

  v(-6pt)

  text(font: fonts.黑体, size: 字号.四号, anonymous-text("supervisor-en", info.supervisor-en))

  if info.supervisor-ii-en != "" {
    v(-4pt)
    text(font: fonts.黑体, size: 字号.四号, anonymous-text("supervisor-ii-en", info.supervisor-ii-en))
    v(-9pt)
  }

  v(26pt)

  [
    A Dissertation Submitted to  \
    Northwestern Polytechnical University  \
    In Partial Fulfillment of The Requirement  \
    For The Degree of  \
  ]

  v(6pt)

  let degree-en-text = if info.degree-en == auto {
    if doctype == "doctor" { "Philosophy" } else { "Engineering" }
  } else {
    info.degree-en
  }

  smallcaps(if doctype == "doctor" { "Doctor of " + degree-en-text } else { "Master of " + degree-en-text })

  v(6pt)

  [in]

  v(6pt)

  info.major-en

  v(40pt)

  if not anonymous {
    text(size: 字号.三号, font: fonts.宋体, weight: "bold")[西北工业大学]
  }

  v(20pt)

  datetime-en-display(info.submit-date)


  // ========================================
  // 第四页 - 评阅人和答辩委员会名单
  // ========================================
  pagebreak(weak: true, to: if twoside { "odd" })

  v(50pt)

  align(center, text(size: 字号.三号, font: fonts.宋体, weight: "bold")[学位论文评阅人和答辩委员会名单])

  v(30pt)

  // 评阅人表格
  align(center)[
    #text(font: fonts.宋体, size: 字号.小三, weight: "bold")[学位论文评阅人名单]

    #v(10pt)

    #block(width: 400pt)[
      #table(
        columns: (1fr, 1fr, 2fr),
        stroke: (x: stroke-width, y: stroke-width),
        inset: (x: 8pt, y: 6pt),
        [*姓名*], [*职称*], [*工作单位*],
        table.cell(colspan: 3, [（评阅人信息待填写）]),
      )
    ]
  ]

  v(30pt)

  // 答辩委员会表格
  align(center)[
    #text(font: fonts.宋体, size: 字号.小三, weight: "bold")[答辩委员会名单]

    #v(10pt)

    #block(width: 450pt)[
      #table(
        columns: (1fr, 1fr, 1fr, 2fr),
        stroke: (x: stroke-width, y: stroke-width),
        inset: (x: 8pt, y: 6pt),
        [*答辩日期*], [], [], [],
        [ ], [ ], [ ], [ ],
        [*答辩委员会*], [*姓名*], [*职称*], [*工作单位*],
        [*主席*], [ ], [ ], [ ],
        [*委员*], [ ], [ ], [ ],
        [*委员*], [ ], [ ], [ ],
        [*委员*], [ ], [ ], [ ],
        [*委员*], [ ], [ ], [ ],
        [*秘书*], [ ], [ ], [ ],
      )
    ]
  ]
}