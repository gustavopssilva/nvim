-- Configuração de linting para Kotlin e outras linguagens
return {
  "mfussenegger/nvim-lint",
  dependencies = { "williamboman/mason.nvim" },
  config = function()
    local lint = require("lint")
    
    -- Configura o ktlint para usar um editorconfig global que desativa as frescuras
    local config_path = vim.fn.stdpath("config") .. "/ktlint.editorconfig"
    lint.linters.ktlint.args = {
      "--reporter=json",
      "--editorconfig=" .. config_path,
      "--stdin-path",
      function() return vim.api.nvim_buf_get_name(0) end,
      "-",
    }

    lint.linters_by_ft = {
      kotlin = { "ktlint" },
    }

    -- Autocmd para rodar o linter ao salvar ou entrar no buffer
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
      group = vim.api.nvim_create_augroup("lint", { clear = true }),
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
