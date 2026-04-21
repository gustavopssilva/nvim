-- tem que instalar o ripgrep
--   sudo apt install ripgrep

return {
  -- https://github.com/nvim-telescope/telescope.nvim
  'nvim-telescope/telescope.nvim',
  lazy = true,
  dependencies = {
    -- https://github.com/nvim-lua/plenary.nvim
    { 'nvim-lua/plenary.nvim' },
    {
      -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    -- Adiciona o neoclip para histórico de yank
    { 'AckslD/nvim-neoclip.lua' },
    -- { 'nvim-telescope/telescope-lsp-handlers.nvim' }, 
  },
  opts = {
    defaults = {
      layout_config = {
        vertical = {
          width = 0.75
        }
      },
      path_display = {
        filename_first = {
          reverse_directories = true
        }
      },
    },
    pickers = {
      colorscheme = {
        enable_preview = true,
        layout_strategy = "center",
        layout_config = {
          width = 0.5,
          height = 0.4,
        },
      }
    },
    extensions = {
      neoclip = {}, -- Ativa o histórico de yank
      -- lsp_handlers = {},     -- deveria ativar os comandos do lsp no telescope...
    }
  },
  config = function(_, opts)
    require('telescope').setup(opts)
    require('telescope').load_extension('neoclip') -- Carrega a extensão
    -- require('telescope').load_extension('lsp_handlers')  -- Carrega a extensão
  end
}

-- -- Fuzzy finder
-- return {
--   -- https://github.com/nvim-telescope/telescope.nvim
--   'nvim-telescope/telescope.nvim',
--   lazy = true,
--   dependencies = {
--     -- https://github.com/nvim-lua/plenary.nvim
--     { 'nvim-lua/plenary.nvim' },
--     {
--       -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
--       'nvim-telescope/telescope-fzf-native.nvim',
--       build = 'make',
--       cond = function()
--         return vim.fn.executable 'make' == 1
--       end,
--     },
--   },
--   opts = {
--     defaults = {
--       layout_config = {
--         vertical = {
--           width = 0.75
--         }
--       },
--       path_display = {
--         filename_first = {
--           reverse_directories = true
--         }
--       },
--     }
--   }
-- }
