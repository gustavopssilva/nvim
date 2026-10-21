-- Aplica os highlights do "eclipse-dark" a partir de uma paleta de cores.
-- Usado pelos arquivos colors/eclipse-dark*.lua para evitar duplicar a
-- definição dos grupos de highlight em cada variante de paleta.

return function(name, p)
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end

  vim.o.background = "dark"
  vim.o.termguicolors = true
  vim.g.colors_name = name

  local hl = vim.api.nvim_set_hl

  -- UI base
  hl(0, "Normal", { fg = p.fg, bg = p.bg })
  hl(0, "NormalNC", { fg = p.fg, bg = p.bg })
  hl(0, "NormalFloat", { fg = p.fg, bg = p.bg_dark })
  hl(0, "FloatBorder", { fg = p.border, bg = p.bg_dark })
  hl(0, "CursorLine", { bg = p.bg_line })
  hl(0, "CursorLineNr", { fg = p.fg, bold = true })
  hl(0, "LineNr", { fg = p.linenr })
  hl(0, "SignColumn", { bg = p.bg })
  hl(0, "VertSplit", { fg = p.border, bg = p.bg })
  hl(0, "WinSeparator", { fg = p.border, bg = p.bg })
  hl(0, "Visual", { bg = p.bg_selection })
  hl(0, "Search", { fg = p.bg, bg = p.warn })
  hl(0, "IncSearch", { fg = p.bg, bg = p.keyword })
  hl(0, "Pmenu", { fg = p.fg, bg = p.bg_dark })
  hl(0, "PmenuSel", { fg = p.bg, bg = p.type })
  hl(0, "StatusLine", { fg = p.fg, bg = p.bg_dark })
  hl(0, "StatusLineNC", { fg = p.fg_dim, bg = p.bg_dark })
  hl(0, "TabLine", { fg = p.fg_dim, bg = p.bg_dark })
  hl(0, "TabLineSel", { fg = p.fg, bg = p.bg })
  hl(0, "EndOfBuffer", { fg = p.bg })
  hl(0, "Whitespace", { fg = p.linenr })
  hl(0, "NonText", { fg = p.linenr })

  -- Sintaxe clássica (vim regex syntax)
  hl(0, "Comment", { fg = p.comment, italic = true })
  hl(0, "Constant", { fg = p.const })
  hl(0, "String", { fg = p.string })
  hl(0, "Character", { fg = p.string })
  hl(0, "Number", { fg = p.number })
  hl(0, "Boolean", { fg = p.number })
  hl(0, "Float", { fg = p.number })
  hl(0, "Identifier", { fg = p.fg })
  hl(0, "Function", { fg = p.func })
  hl(0, "Statement", { fg = p.keyword, bold = false })
  hl(0, "Conditional", { fg = p.keyword })
  hl(0, "Repeat", { fg = p.keyword })
  hl(0, "Keyword", { fg = p.keyword })
  hl(0, "Operator", { fg = p.fg })
  hl(0, "PreProc", { fg = p.const })
  hl(0, "Type", { fg = p.type })
  hl(0, "Structure", { fg = p.type })
  hl(0, "Special", { fg = p.const })
  hl(0, "Underlined", { fg = p.type, underline = true })
  hl(0, "Error", { fg = p.error })
  hl(0, "Todo", { fg = p.bg, bg = p.warn, bold = true })

  -- Treesitter (@captures)
  hl(0, "@variable", { fg = p.fg })
  hl(0, "@function", { fg = p.func })
  hl(0, "@function.call", { fg = p.func })
  hl(0, "@method", { fg = p.func })
  hl(0, "@keyword", { fg = p.keyword })
  hl(0, "@keyword.function", { fg = p.keyword })
  hl(0, "@keyword.return", { fg = p.keyword })
  hl(0, "@string", { fg = p.string })
  hl(0, "@number", { fg = p.number })
  hl(0, "@boolean", { fg = p.number })
  hl(0, "@type", { fg = p.type })
  hl(0, "@type.builtin", { fg = p.type })
  hl(0, "@constant", { fg = p.const })
  hl(0, "@constant.builtin", { fg = p.const })
  hl(0, "@comment", { fg = p.comment, italic = true })
  hl(0, "@punctuation.bracket", { fg = p.fg })
  hl(0, "@punctuation.delimiter", { fg = p.fg })
  hl(0, "@property", { fg = p.fg })
  hl(0, "@parameter", { fg = p.fg })

  -- Diagnósticos (LSP)
  hl(0, "DiagnosticError", { fg = p.error })
  hl(0, "DiagnosticWarn", { fg = p.warn })
  hl(0, "DiagnosticInfo", { fg = p.type })
  hl(0, "DiagnosticHint", { fg = p.comment })

  -- Diff
  hl(0, "DiffAdd", { fg = p.string, bg = p.bg_dark })
  hl(0, "DiffChange", { fg = p.warn, bg = p.bg_dark })
  hl(0, "DiffDelete", { fg = p.error, bg = p.bg_dark })
  hl(0, "DiffText", { fg = p.fg, bg = p.bg_selection })

  require("core.transparencia")()
end
