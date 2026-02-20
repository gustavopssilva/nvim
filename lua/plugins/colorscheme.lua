-- I
--
-- return {
--   "navarasu/onedark.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require('onedark').setup({
--       style = 'dark',  -- 'dark' | 'darker' | 'cool' | 'deep' | 'warm' | 'warmer' | 'light'
--       transparent = true, -- Habilita fundo transparente
--       term_colors = true,
--       ending_tildes = false,

--       highlights = {
--         -- Comment = { italic = true },
--         -- Keyword = { bold = true },
--         -- Adicione outros highlights personalizados se necessário
--       }
--     })

--     vim.cmd("colorscheme onedark")

--   end,
-- }
--
return {
  "nanotech/jellybeans.vim",
  lazy = false,
  priority = 1000,
  config = function()
    ---@diagnostic disable: undefined-global
    vim.cmd("colorscheme jellybeans")

    -- Transparência
    vim.cmd([[
      highlight Normal guibg=NONE ctermbg=NONE
      highlight NormalNC guibg=NONE ctermbg=NONE
      highlight VertSplit guibg=NONE ctermbg=NONE
      highlight SignColumn guibg=NONE ctermbg=NONE
      highlight StatusLine guibg=NONE ctermbg=NONE
      highlight LineNr guibg=NONE ctermbg=NONE
      highlight Pmenu guibg=NONE ctermbg=NONE
      highlight PmenuSel guibg=NONE ctermbg=NONE
      highlight TelescopeBorder guibg=NONE ctermbg=NONE
      highlight TelescopeNormal guibg=NONE ctermbg=NONE
      highlight EndOfBuffer guibg=NONE ctermbg=NONE
    ]])
    vim.cmd([[
  highlight Whitespace guibg=NONE ctermbg=NONE
  highlight SpecialKey guibg=NONE ctermbg=NONE
  highlight NonText guibg=NONE ctermbg=NONE
]])
    -- Estilo
    -- vim.cmd([[
    --   highlight Comment gui=italic
    --   highlight Keyword gui=bold
    -- ]])
  end,
}
