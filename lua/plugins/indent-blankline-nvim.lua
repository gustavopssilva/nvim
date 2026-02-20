-- Indentation guides
return {
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",
  main = "ibl",
  config = function()
    -- cria os highlights antes
    vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3b3f4c", bg = "NONE" })
    vim.api.nvim_set_hl(0, "IblWhitespace", { fg = "#3b3f4c", bg = "NONE" })
    vim.api.nvim_set_hl(0, "IblScope", { fg = "#5c6370", bg = "NONE" })

    require("ibl").setup({
      indent = {
        char = "|",
        highlight = { "IblIndent" },
      },
      whitespace = {
        highlight = { "IblWhitespace" },
      },
      scope = {
        highlight = { "IblScope" },
      },
      exclude = {
        filetypes = { "java", "json", "kotlin" },
      },
    })
  end,
}
