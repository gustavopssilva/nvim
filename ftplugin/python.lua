-- ve se ta instalado: pyright-langserver --version
-- ou assim: which pyright-langserver
-- instalar o python: npm install -g pyright



local lspconfig = require("lspconfig")

-- Diz pro LazyVim usar Pyright como LSP Python
vim.g.lazyvim_python_lsp = "pyright"

-- Mata qualquer cliente baseado em BasedPyright ativo ou Pyright diferente do caminho definido
for _, client in pairs(vim.lsp.get_active_clients()) do
  if client.name == "basedpyright" or
     (client.name == "pyright" and client.cmd[1] ~= "/home/gustavo/.nvm/versions/node/v22.13.1/bin/pyright-langserver") then
    client.stop()
  end
end

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
  root_dir = function() return vim.loop.cwd() end,
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
