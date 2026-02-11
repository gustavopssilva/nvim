-- local lspconfig = require("lspconfig")

-- -- Evita subir eslint no JavaScript
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client and client.name == "eslint" then
--       client.stop()
--     end
--   end,
-- })

-- -- Sobe apenas o quick-lint-js
-- lspconfig.quick_lint_js.setup({
--   on_attach = function(client, bufnr)
--     -- desliga formatação pelo LSP (opcional)
--     client.server_capabilities.documentFormattingProvider = false
--     client.server_capabilities.documentRangeFormattingProvider = false
--   end,
-- })

