// 显示中文日期（无前导零）
#let datetime-display(date) = {
  str(date.year()) + " 年 " + str(date.month()) + " 月 " + str(date.day()) + " 日"
}

// 显示年月（无前导零）
#let datetime-year-month(date) = {
  str(date.year()) + " 年 " + str(date.month()) + " 月"
}

// 显示英文年月（如 March/2026）
#let datetime-year-month-en(date) = {
  let months = ("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")
  months.at(date.month() - 1) + "/" + str(date.year())
}