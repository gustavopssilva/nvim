return {
  -- Configuração LSP
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    -- Gerenciamento LSP
    { 'williamboman/mason.nvim',                  config = true },
    { 'williamboman/mason-lspconfig.nvim' },
    -- Auto-instalação de LSPs, linters, formatadores, depuradores
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    -- Atualizações úteis de status para LSP
    { 'j-hui/fidget.nvim',                        opts = {} },
    -- Configuração adicional do lua, torna as coisas no nvim incríveis!
    { 'folke/neodev.nvim',                        opts = {} },
  },
  config = function()
    -- Configurar o Mason
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = {
        'bashls', 'cssls', 'html', 'gradle_ls', 'groovyls', 'lua_ls',
        'jdtls', 'jsonls', 'lemminx', 'marksman',
        'yamlls', 'ts_ls', 'tailwindcss', 'pyright'
      }
    })

    -- Configurar o Mason Tool Installer
    require('mason-tool-installer').setup({
      ensure_installed = { 'java-debug-adapter', 'java-test', 'ktlint' },
    })

    -- Chamar a instalação do Mason Tools manualmente
    vim.api.nvim_command('MasonToolsInstall')

    -- Definir variáveis de configuração LSP
    local lspconfig = require('lspconfig')
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lsp_attach = function(client, bufnr)
      -- Defina os bindings de teclas aqui...
      -- Desativa a formatação pelo LSP para usar outro formatador (ex: null-ls)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false


      -- Keymaps básicos LSP se for redundante, pode tirar depois 250705
      local opts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<leader>ga', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', '<leader>gf', function() vim.lsp.buf.format { async = true } end, opts)
    end


    local servers = {
      'bashls', 'cssls', 'html', 'gradle_ls', 'groovyls', 'lua_ls',
      'jsonls', 'lemminx', 'marksman', 'yamlls',
      'tailwindcss', 'pyright'
    }


    for _, server in ipairs(servers) do
      if server == "lua_ls" then
        lspconfig.lua_ls.setup({
          on_attach = lsp_attach,
          capabilities = lsp_capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
            },
          },
        })
      else
        lspconfig[server].setup({
          on_attach = lsp_attach,
          capabilities = lsp_capabilities,
        })
      end
    end
  end
}
