-- ve se ta instalado: pyright-langserver --version
-- ou assim: which pyright-langserver
-- instalar o python: npm install -g pyright
-- (ou via :Mason — já está em ensure_installed)

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Setup do Pyright (type checking, hover, go-to-definition)
lspconfig.pyright.setup({
  cmd = { "pyright-langserver", "--stdio" },
  on_attach = function(client, bufnr)
    -- Desativa formatação pelo LSP (use conform/black via <leader>l)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    -- Keymaps LSP globais definidos em lua/core/keymaps.lua
  end,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
      },
    },
  },
})

-- Setup do Ruff (linting + code actions)
-- Pyright cuida de hover/definitions; ruff foca em lint e quick-fixes
lspconfig.ruff.setup({
  on_attach = function(client, bufnr)
    -- Desativa hover do ruff pra não conflitar com pyright
    client.server_capabilities.hoverProvider = false
    -- Formatação fica com conform (black). Pra trocar pra ruff_format,
    -- ajuste lua/plugins/conform-nvim.lua
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  capabilities = capabilities,
})
