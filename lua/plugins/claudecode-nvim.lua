-- https://github.com/coder/claudecode.nvim?tab=readme-ov-file
-- claude init e claude migrate-installer
return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      terminal_cmd = "~/.claude/local/claude", -- Point to local installation
    },
    config = true,
    keys = {
      { "<leader>a",  nil,                              desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                  desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
    },
  }
}


-- Usage

--     Launch Claude: Run :ClaudeCode to open Claude in a split terminal
--     Send context:
--         Select text in visual mode and use <leader>as to send it to Claude
--         In nvim-tree/neo-tree/oil.nvim/mini.nvim, press <leader>as on a file to add it to Claude's context
--     Let Claude work: Claude can now:
--         See your current file and selections in real-time
--         Open files in your editor
--         Show diffs with proposed changes
--         Access diagnostics and workspace info

-- Key Commands

--     :ClaudeCode - Toggle the Claude Code terminal window
--     :ClaudeCodeFocus - Smart focus/toggle Claude terminal
--     :ClaudeCodeSelectModel - Select Claude model and open terminal with optional arguments
--     :ClaudeCodeSend - Send current visual selection to Claude
--     :ClaudeCodeAdd <file-path> [start-line] [end-line] - Add specific file to Claude context with optional line range
--     :ClaudeCodeDiffAccept - Accept diff changes
--     :ClaudeCodeDiffDeny - Reject diff changes

-- Working with Diffs

-- When Claude proposes changes, the plugin opens a native Neovim diff view:

--     Accept: :w (save) or <leader>aa
--     Reject: :q or <leader>ad

-- You can edit Claude's suggestions before accepting them.
