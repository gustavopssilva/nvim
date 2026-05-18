return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    workspaces = {
      {
        name = "Obs",
        path = "/home/gps2/Dropbox/obsidian/Obs",
      },
    },
    daily_notes = {
      folder = "System/Daily",
      date_format = "%Y-%m-%d",
      template = "template_Notes daily.md"
    },
    templates = {
      folder = "System/Template",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- New note
      ["<leader>on"] = {
        action = function()
          return vim.cmd("ObsidianNew")
        end,
        opts = { buffer = true },
      },
      -- Today's note
      ["<leader>ot"] = {
        action = function()
          return vim.cmd("ObsidianToday")
        end,
        opts = { buffer = true },
      },
      -- Search notes
      ["<leader>os"] = {
        action = function()
          return vim.cmd("ObsidianSearch")
        end,
        opts = { buffer = true },
      },
      -- Insert template
      ["<leader>oi"] = {
        action = function()
          return vim.cmd("ObsidianTemplate")
        end,
        opts = { buffer = true },
      },
    },
    ui = {
      enable = false,
      update_debounce = 200,
      checkboxes = {
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
        [">"] = { char = "󰭹", hl_group = "ObsidianRightArrow" },
        ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
      },
    },
  },
}
