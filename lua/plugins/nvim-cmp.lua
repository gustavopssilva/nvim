-- Auto-completar e Snippets
return {
  -- Plugin principal para auto-completar
  -- https://github.com/hrsh7th/nvim-cmp
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    -- Motor de snippets e integração com nvim-cmp
    -- https://github.com/L3MON4D3/LuaSnip
    'L3MON4D3/LuaSnip',
    -- Plugin para conectar LuaSnip ao nvim-cmp
    -- https://github.com/saadparwaiz1/cmp_luasnip
    'saadparwaiz1/cmp_luasnip',

    -- Auto-completar baseado no LSP
    -- https://github.com/hrsh7th/cmp-nvim-lsp
    'hrsh7th/cmp-nvim-lsp',

    -- Pacote de snippets prontos para várias linguagens
    -- https://github.com/rafamadriz/friendly-snippets
    'rafamadriz/friendly-snippets',

    -- Auto-completar baseado no conteúdo do buffer atual
    -- https://github.com/hrsh7th/cmp-buffer
    'hrsh7th/cmp-buffer',

    -- Auto-completar para caminhos de arquivos
    -- https://github.com/hrsh7th/cmp-path
    'hrsh7th/cmp-path',

    -- Auto-completar no modo de linha de comando
    -- https://github.com/hrsh7th/cmp-cmdline
    'hrsh7th/cmp-cmdline',
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    -- Carrega snippets do formato VS Code
    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip.loaders.from_lua').load({ paths = { vim.fn.stdpath("config") .. "/lua/snippets" } })
    luasnip.config.setup({})

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },

      -- Configuração dos atalhos para navegação nas sugestões
      mapping = cmp.mapping.preset.insert {
        ['<C-j>'] = cmp.mapping.select_next_item(), -- Próxima sugestão
        ['<C-k>'] = cmp.mapping.select_prev_item(), -- Sugestão anterior
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),    -- Rolar documentação para cima
        ['<C-f>'] = cmp.mapping.scroll_docs(4),     -- Rolar documentação para baixo
        ['<C-Space>'] = cmp.mapping.complete {},    -- Mostrar sugestões de auto-completar
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },

        -- Atalho para percorrer sugestões ou pular argumentos dentro de um snippet
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),

        -- Mesma lógica do <Tab>, mas para navegar para trás
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },

      -- Configuração das fontes de auto-completar
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- Sugestões do LSP
        { name = "luasnip" },  -- Sugestões de snippets
        { name = "buffer" },   -- Sugestões baseadas no buffer atual
        { name = "path" },     -- Sugestões para caminhos de arquivos
      }),

      window = {
        -- Adicionar bordas às janelas de sugestões e documentação
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })

    -- Autocompletar tabelas/colunas em arquivos SQL via dadbod
    cmp.setup.filetype({ 'sql', 'mysql', 'plsql' }, {
      sources = cmp.config.sources({
        { name = 'vim-dadbod-completion' },
        { name = 'buffer' },
      }),
    })
  end,
}
