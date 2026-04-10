-- ╔══════════════════════════════════════════════════════════════════╗
-- ║                    SNIPPETS JAVA - LUASNIP                      ║
-- ╠══════════════════════════════════════════════════════════════════╣
-- ║  Como funciona:                                                 ║
-- ║                                                                 ║
-- ║  s("gatilho", { ... })  → define o snippet                     ║
-- ║    - "gatilho" = o que você digita pra ativar                   ║
-- ║                                                                 ║
-- ║  Nós (nodes) disponíveis:                                       ║
-- ║    t("texto")           → texto fixo (não editável)             ║
-- ║    i(N, "placeholder")  → campo editável, Tab pula pro próximo  ║
-- ║                           N = ordem (1, 2, 3...), 0 = posição   ║
-- ║                           final do cursor                       ║
-- ║    f(função, {deps})    → texto gerado por função lua           ║
-- ║                                                                 ║
-- ║  Múltiplas linhas:                                              ║
-- ║    t({"linha1", "linha2"})  → cada item = uma linha             ║
-- ║    t({"", ""})              → quebra de linha vazia             ║
-- ║                                                                 ║
-- ║  Para criar um novo snippet:                                    ║
-- ║    1. Copie um exemplo abaixo                                   ║
-- ║    2. Troque o "gatilho"                                        ║
-- ║    3. Monte o corpo com t() e i()                               ║
-- ║    4. Salve e recarregue (:luafile %)                           ║
-- ╚══════════════════════════════════════════════════════════════════╝

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

ls.add_snippets("java", {

  ---------------------------------------------------
  -- SIMPLES: só texto fixo
  -- digite "sout" e vira System.out.println("...");
  ---------------------------------------------------
  s("sout", {
    t('System.out.println('),
    i(1, '"mensagem"'),        -- cursor para aqui primeiro (Tab pra sair)
    t(');'),
  }),

  ---------------------------------------------------
  -- COM VÁRIOS CAMPOS: Tab pula entre eles
  -- digite "for" e monta um for clássico
  ---------------------------------------------------
  s("fori", {
    t("for (int "),
    i(1, "i"),                 -- 1º campo: variável
    t(" = 0; "),
    i(2, "i"),                 -- 2º campo: condição
    t(" < "),
    i(3, "n"),                 -- 3º campo: limite
    t("; "),
    i(4, "i"),                 -- 4º campo: incremento
    t({ "++) {", "    " }),    -- abre chave + indentação
    i(0),                      -- posição final do cursor
    t({ "", "}" }),            -- fecha chave
  }),

  ---------------------------------------------------
  -- MÚLTIPLAS LINHAS: main method
  -- digite "main"
  ---------------------------------------------------
  s("main", {
    t({ "public static void main(String[] args) {", "    " }),
    i(0),
    t({ "", "}" }),
  }),

  ---------------------------------------------------
  -- COM FUNÇÃO: pega o nome do arquivo como classe
  -- digite "class"
  ---------------------------------------------------
  s("class", {
    t("public class "),
    f(function()
      return vim.fn.expand("%:t:r")  -- nome do arquivo sem extensão
    end, {}),
    t({ " {", "    " }),
    i(0),
    t({ "", "}" }),
  }),

})
