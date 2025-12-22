return {
  "nvimtools/none-ls.nvim",
  optional = false,
  opts = function(_, opts)
    local nls = require("null-ls")

    -- Formatter customizado para pgFormatter
    local pgformatter = nls.builtins.formatting.prettierd.with({
      name = "pgformatter",
      method = nls.methods.FORMATTING,
      filetypes = { "sql" },
      generator = nls.generator({
        command = "pg_format",         -- comando do pgFormatter
        args = { "--stdin", "--spaces", "2" },  -- lê do stdin e indentação 2 espaços
        to_stdin = true,
      }),
    })

    -- Lista de formatadores/linter
    opts.sources = vim.list_extend(opts.sources or {}, {
      -- JSON/YAML/Markdown
      nls.builtins.formatting.prettierd,
      -- SQL via pgFormatter
      pgformatter,
      -- outros linters/formatters podem ser adicionados aqui
    })

    -- Formatação automática ao salvar
    opts.on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        -- Tecla manual de formatação
        vim.api.nvim_buf_set_keymap(
          bufnr,
          "n",
          "<leader>gf",
          "<cmd>lua vim.lsp.buf.format({ bufnr = bufnr })<CR>",
          { noremap = true, silent = true, desc = "Formatar arquivo" }
        )
      end
    end
  end,
}
