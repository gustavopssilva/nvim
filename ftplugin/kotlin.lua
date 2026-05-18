-- evita setup duplicado do kotlin_language_server
if vim.g._kls_loaded then
  return
end
vim.g._kls_loaded = true

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local root_pattern = function(fname)
  return lspconfig.util.root_pattern(
    "pom.xml",
    "build.gradle",
    "build.gradle.kts",
    "settings.gradle",
    "settings.gradle.kts",
    ".git"
  )(fname)
end

-- Gera .kls-classpath apenas para projetos Maven que não têm o arquivo
local project_root = vim.fn.getcwd()
local classpath_file = project_root .. "/.kls-classpath"
local pom_file = project_root .. "/pom.xml"

if vim.fn.filereadable(pom_file) == 1 and vim.fn.filereadable(classpath_file) == 0 then
  vim.notify("Gerando .kls-classpath...", vim.log.levels.INFO)
  vim.fn.system("mvn dependency:build-classpath -Dmdep.outputFile=.kls-classpath")
end

-- Configuração do servidor Kotlin
lspconfig.kotlin_language_server.setup({
  on_attach = function(client, bufnr)
    -- Desativa formatação pelo LSP (usa conform.nvim com ktlint via <leader>l)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  capabilities = capabilities,
  root_dir = root_pattern,
  settings = {
    kotlin = {
      compiler = {
        dependencyClasspath = { ".kls-classpath" },
      },
    },
  },
})

-- O ftplugin roda APÓS o FileType, então o autocmd do lspconfig já passou
-- e não anexa no buffer atual. Força anexar manualmente.
local bufnr = vim.api.nvim_get_current_buf()
vim.schedule(function()
  local cfg = require("lspconfig.configs").kotlin_language_server
  if cfg and cfg.manager then
    cfg.manager:try_add(bufnr)
  end
end)
