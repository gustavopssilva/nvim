-- evita setup duplicado do kotlin_language_server
if vim.g._kls_loaded then
  return
end
vim.g._kls_loaded = true
-- ===============================
-- LSP Kotlin
-- ===============================
local lspconfig = require("lspconfig")
require("lspconfig").jdtls.setup({
  filetypes = { "java" }, -- não abre em kotlin
  root_dir = function(fname)
    return require("lspconfig").util.root_pattern(
      "pom.xml",
      "build.gradle",
      "build.gradle.kts",
      "settings.gradle",
      "settings.gradle.kts"
    )(fname)
  end
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function on_attach(client, bufnr)
  -- Desativa formatação pelo LSP (usaremos null-ls/ktlint)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>ga', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>gf', function() vim.lsp.buf.format { async = true } end, opts)
end


-- local root_pattern = function(fname)
--   return lspconfig.util.root_pattern("pom.xml", ".git")(fname)
-- end

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


-- Garante que o classpath Maven exista
local project_root = vim.fn.getcwd()
local classpath_file = project_root .. "/.kls-classpath"

if vim.fn.filereadable(classpath_file) == 0 then
  print("Gerando .kls-classpath...")
  vim.fn.system("mvn dependency:build-classpath -Dmdep.outputFile=.kls-classpath")
end
-- Configuração do servidor Kotlin
lspconfig.kotlin_language_server.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = root_pattern,
  cmd = { "kotlin-language-server" },
  settings = {
    kotlin = {
      compiler = {
        dependencyClasspath = { ".kls-classpath" },
        noStdlib = true,
        noJdk = true,
      }
    }
  }
})

-- lspconfig.kotlin_language_server.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   root_dir = root_pattern,
--   cmd = { "kotlin-language-server" },
-- })

-- Autocompletar configurado globalmente em lua/plugins/nvim-cmp.lua


