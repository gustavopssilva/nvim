-- TOPO do arquivo (antes do return)
vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/site")
vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/site/pack/packer/start/nvim-treesitter")
vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/lazy/nvim-treesitter")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup {
        parser_install_dir = vim.fn.stdpath("data") .. "/site/parser",
        highlight = {
          enable = true,
        },
      }
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    opts = {},
  }
}
