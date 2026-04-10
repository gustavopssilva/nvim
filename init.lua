vim.env.TREESITTER_PARSER_DIR = vim.fn.stdpath("data") .. "/site/parser"
-- vim.opt.runtimepath:append("~/.local/share/nvim/site")

-- Silencia warnings de deprecação do lspconfig (até migrar pra vim.lsp.config)
local orig_deprecate = vim.deprecate
vim.deprecate = function(name, alternative, version, plugin, backtrace)
  if plugin == "nvim-lspconfig" then return end
  if orig_deprecate then return orig_deprecate(name, alternative, version, plugin, backtrace) end
end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configurações gerais
vim.g.mapleader = " "

-- Inicializa lazy.nvim e carrega os plugins da pasta lua/plugins
require("lazy").setup("plugins", {
  change_detection = {
    enabled = true,
    notify = false,
  },
})

-- Carrega configurações principais
require("core.options")
require("core.keymaps")

-- Carrega os snippets personalizados
require("luasnip.loaders.from_lua").load({ paths = { vim.fn.stdpath("config") .. "/lua/snippets" } })
