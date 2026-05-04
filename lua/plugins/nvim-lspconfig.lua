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
        'jsonls', 'lemminx', 'marksman',
        'yamlls', 'ts_ls', 'pyright', 'sqls'
      },
      -- jdtls é gerenciado pelo nvim-jdtls (ftplugin/java.lua), não pelo mason-lspconfig
      -- automatic_enable = false impede que servidores instalados via Mason (mas não
      -- configurados explicitamente abaixo) ataquem buffers automaticamente
      automatic_enable = false,
    })

    -- Configurar o Mason Tool Installer (instala sob demanda, sem rodar no startup)
    require('mason-tool-installer').setup({
      ensure_installed = { 'java-debug-adapter', 'java-test', 'ktlint' },
      run_on_start = false,
    })

    -- Definir variáveis de configuração LSP
    local lspconfig = require('lspconfig')
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lsp_attach = function(client, bufnr)
      -- Defina os bindings de teclas aqui...
      -- Desativa a formatação pelo LSP para usar outro formatador (ex: null-ls)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false


      -- Keymaps LSP definidos em core/keymaps.lua
    end


    local servers = {
      'bashls', 'cssls', 'html', 'gradle_ls', 'groovyls', 'lua_ls',
      'jsonls', 'lemminx', 'marksman', 'yamlls',
      'pyright', 'sqls'
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

    -- TypeScript — setup dedicado com limite de memória
    lspconfig.ts_ls.setup({
      on_attach = lsp_attach,
      capabilities = lsp_capabilities,
      init_options = {
        maxTsServerMemory = 4096,
      },
      flags = {
        debounce_text_changes = 300,
      },
    })
  end
}
