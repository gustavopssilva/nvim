-- ve se ta instalado: pyright-langserver --version
-- ou assim: which pyright-langserver
-- instalar o python: npm install -g pyright



local lspconfig = require("lspconfig")

-- Setup do Pyright
lspconfig.pyright.setup({
  cmd = { "pyright-langserver", "--stdio" },
  -- cmd = { "/home/gustavo/.nvm/versions/node/v22.13.1/bin/pyright-langserver", "--stdio" },
  on_attach = function(client, bufnr)
    -- Desativa formatação pelo LSP (use outro formatador se quiser)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    -- Keymaps LSP
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>ga', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>gf', function() vim.lsp.buf.format { async = true } end, opts)
  end,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  root_dir = function() return vim.uv.cwd() end,
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
