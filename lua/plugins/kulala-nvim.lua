return {
  'mistweaverco/kulala.nvim',
  -- lazy = false, -- Garante que o plugin carregue para o comando :Kulala existir
  init = function()
    vim.filetype.add({
      extension = {
        ["http"] = "http",
        ["rest"] = "http",
      },
    })
  end,
  config = function()
    require('kulala').setup({
      display_mode = "float", -- "split" ou "float"
      show_icons = "on_request",
    })

    -- Atalhos específicos para Kulala
    vim.keymap.set('n', '<leader>r', '<cmd>lua require("kulala").run()<cr>', { desc = 'Executar requisição HTTP' })
    vim.keymap.set('n', '<leader>i', '<cmd>lua require("kulala").inspect()<cr>', { desc = 'Inspecionar requisição (Headers)' })
    vim.keymap.set('n', '[', '<cmd>lua require("kulala").jump_prev()<cr>', { desc = 'Ir para requisição anterior' })
    vim.keymap.set('n', ']', '<cmd>lua require("kulala").jump_next()<cr>', { desc = 'Ir para próxima requisição' })
  end,
}
