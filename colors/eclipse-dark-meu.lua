-- Colorscheme "eclipse-dark-meu" — valores oficiais extraídos do CSS do
-- tema Dark do Eclipse:
--   - org.eclipse.ui.themes (eclipse-platform/eclipse.platform.ui),
--     css/dark/e4-dark_preferencestyle.css → fundo, seleção, linha atual,
--     número de linha.
--   - org.eclipse.jdt.ui (eclipse-jdt/eclipse.jdt.ui),
--     css/e4-dark_jdt_syntaxhighlighting.css → keyword, string, comentário,
--     tipos (via semantic highlighting).
--
-- Simplificações conscientes:
--   - Methods (chamadas/declarações) ficam na cor padrão do texto: no
--     Eclipse "Method"/"Method invocation" no Semantic Highlighting vêm
--     desligados por padrão, então métodos não recebem cor própria.
--   - Tags de javadoc (@param, @return, @throws) usam a mesma cor do
--     comentário — o Treesitter não separa isso do corpo do comentário
--     sem uma query dedicada.

local p = {
  bg = "#1e1f22",
  bg_dark = "#34393d",
  bg_line = "#373737",
  bg_selection = "#214283",
  fg = "#cccccc",
  fg_dim = "#8a8a8a",
  comment = "#808080",
  keyword = "#cc6c1d",
  string = "#17c6a3",
  number = "#6897bb",
  func = "#cccccc",
  type = "#1290c3",
  const = "#a0a0a0",
  error = "#f74475",
  warn = "#ffc800",
  linenr = "#77919a",
  border = "#515658",
}

require("eclipse-dark.apply")("eclipse-dark-meu", p)
