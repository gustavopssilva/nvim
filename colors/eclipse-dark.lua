-- Colorscheme "eclipse-dark" — variante com contraste intermediário
-- (meio-termo entre eclipse-dark-soft e a versão mais vibrante testada).
-- Aproximação do tema Dark do Eclipse IDE, não um match oficial.

local p = {
  bg = "#2b2b2b",
  bg_dark = "#242424",
  bg_line = "#323232",
  bg_selection = "#3a4048",
  fg = "#cfcfcf",
  fg_dim = "#8a8a8a",
  comment = "#6ca76c",
  keyword = "#de9d53",
  string = "#9bc279",
  number = "#62afc5",
  func = "#dfc872",
  type = "#78b4e0",
  const = "#bd82d3",
  error = "#e06c75",
  warn = "#e5c07b",
  linenr = "#5c6066",
  border = "#454545",
}

require("eclipse-dark.apply")("eclipse-dark", p)
