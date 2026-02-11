
vim.deprecate = function() end
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
-- require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets/" })
-- require("luasnip.loaders.From_lua").load({ paths = "./lua/snippets/" })
-- require("luasnip.loaders.from_lua").load({ paths = "./lua/snippets/" })
require("luasnip.loaders.from_lua").load({ paths = { "./lua/snippets/" } })
