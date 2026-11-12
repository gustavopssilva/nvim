-- Resolução de conflitos de merge inline (estilo VS Code: Accept Current/Incoming/Both)
local function resolver_todos(comando)
  vim.api.nvim_win_set_cursor(0, { 1, 0 })
  while vim.fn.search("^<<<<<<<", "W") > 0 do
    local linha = vim.fn.line(".")
    vim.cmd(comando)
    if vim.fn.getline(linha):match("^<<<<<<<") then
      break
    end
  end
end

return {
  -- https://github.com/akinsho/git-conflict.nvim
  "akinsho/git-conflict.nvim",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  opts = { default_mappings = false },
  keys = {
    { "<leader>mo", "<cmd>GitConflictChooseOurs<CR>", desc = "Conflito: aceitar atual (ours)" },
    { "<leader>mt", "<cmd>GitConflictChooseTheirs<CR>", desc = "Conflito: aceitar recebido (theirs)" },
    { "<leader>mb", "<cmd>GitConflictChooseBoth<CR>", desc = "Conflito: aceitar ambos" },
    { "<leader>mn", "<cmd>GitConflictChooseNone<CR>", desc = "Conflito: descartar ambos" },
    { "<leader>mj", "<cmd>GitConflictNextConflict<CR>", desc = "Próximo conflito" },
    { "<leader>mk", "<cmd>GitConflictPrevConflict<CR>", desc = "Conflito anterior" },
    { "<leader>mq", "<cmd>GitConflictListQf<CR>", desc = "Listar conflitos (quickfix)" },
    { "<leader>mO", function() resolver_todos("GitConflictChooseOurs") end, desc = "Todos os conflitos: atual (ours)" },
    { "<leader>mT", function() resolver_todos("GitConflictChooseTheirs") end, desc = "Todos os conflitos: recebido (theirs)" },
  },
}
