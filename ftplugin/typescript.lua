-- ~/.config/nvim/ftplugin/typescript.lua

-- Instalar o LSP:
-- npm install -g typescript-language-server typescript

local nvim_lsp = require('lspconfig')

-- Configuração do LSP para TypeScript
-- nvim_lsp.tsserver.setup({
  nvim_lsp.ts_ls.setup({

  on_attach = function(client, bufnr)
    -- Formatar ao salvar
    -- vim.api.nvim_create_autocmd("BufWritePre", {
    --   buffer = bufnr,
    --   callback = function()
    --     vim.lsp.buf.format({ async = false })
    --   end,
    -- })

    -- Atalho para formatar manualmente
    vim.keymap.set('n', '<leader>gf', function()
      vim.lsp.buf.format({ async = false })
    end, { buffer = bufnr, desc = "Formatar código" })
  end,
  flags = {
    debounce_text_changes = 150,
  },
})

-- Autocompletar com nvim-cmp
local cmp = require('cmp')

cmp.setup({
  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-y>"] = cmp.mapping.confirm(),
    ["<C-e>"] = cmp.mapping.abort(),
  },
  sources = {
    { name = 'buffer' },
    { name = 'nvim_lsp' },
    { name = 'path' },
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

