-- Configurações específicas para Kotlin
-- O LSP kotlin_language_server é configurado globalmente em lua/plugins/nvim-lspconfig.lua

-- Kotlin padrão é 4 espaços (ktlint reclama se for 2)
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true

-- Força o carregamento do LSP se ele não estiver anexado (failsafe)
local bufnr = vim.api.nvim_get_current_buf()
vim.schedule(function()
  local cfg = require("lspconfig.configs").kotlin_language_server
  if cfg and cfg.manager then
    cfg.manager:try_add(bufnr)
  end
end)
