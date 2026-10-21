-- Colorscheme "eclipse-dark-soft" — variante original, mais dessaturada.
-- Aproximação do tema Dark do Eclipse IDE, não um match oficial.

local p = {
  bg = "#2b2b2b",
  bg_dark = "#242424",
  bg_line = "#323232",
  bg_selection = "#3a4048",
  fg = "#c6c6c6",
  fg_dim = "#8a8a8a",
  comment = "#6a8f6a",
  keyword = "#d4a76a",
  string = "#9fc27a",
  number = "#6fa8c9",
  func = "#d9c97a",
  type = "#8fb9d1",
  const = "#b58cc9",
  error = "#e06c75",
  warn = "#e5c07b",
  linenr = "#5c6066",
  border = "#454545",
}

require("eclipse-dark.apply")("eclipse-dark-soft", p)
