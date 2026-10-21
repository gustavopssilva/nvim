-- Tema ativo: troque aqui para mudar de colorscheme
-- ("jellybeans" | "onedark" | "eclipse-dark" | "eclipse-dark-soft" | "eclipse-dark-meu")
-- local THEME = "eclipse-dark-soft" -- "jellybeans"
-- local THEME =  "jellybeans"
local THEME =  "eclipse-dark"

local function ativo(nome)
  return THEME == nome
end

local transparencia = require("core.transparencia")

-- Colorschemes "eclipse-dark*" são locais em colors/ (sem plugin git) e aplicam
-- a transparência por conta própria em lua/eclipse-dark/apply.lua.
if ativo("eclipse-dark") or ativo("eclipse-dark-soft") or ativo("eclipse-dark-meu") then
  vim.cmd("colorscheme " .. THEME)
end

return {
  {
    "nanotech/jellybeans.vim",
    lazy = not ativo("jellybeans"),
    priority = ativo("jellybeans") and 1000 or nil,
    config = function()
      ---@diagnostic disable: undefined-global
      vim.cmd("colorscheme jellybeans")
      transparencia()

      -- Estilo
      -- vim.cmd([[
      --   highlight Comment gui=italic
      --   highlight Keyword gui=bold
      -- ]])
    end,
  },
  {
    "navarasu/onedark.nvim",
    lazy = not ativo("onedark"),
    priority = ativo("onedark") and 1000 or nil,
    config = function()
      require("onedark").setup({
        style = "dark", -- 'dark' | 'darker' | 'cool' | 'deep' | 'warm' | 'warmer' | 'light'
        transparent = true,
        term_colors = true,
        ending_tildes = false,
        highlights = {
          -- Comment = { italic = true },
          -- Keyword = { bold = true },
        },
      })

      vim.cmd("colorscheme onedark")
    end,
  },
}
