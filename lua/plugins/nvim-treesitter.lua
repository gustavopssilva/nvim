-- Code Tree Support / Syntax Highlighting
-- Branch `main` (nova arquitetura). O branch master foi arquivado e quebra com
-- o nvim 0.12 (match[capture_id] virou lista de TSNode, predicates antigos
-- chamavam :range() em table). Aqui usamos a API nova: setup minimal, install
-- explicito e vim.treesitter.start() por buffer via FileType autocmd.
return {
  -- https://github.com/nvim-treesitter/nvim-treesitter
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',

  dependencies = {
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      branch = 'main',
    },
  },

  -- Lista que `:TSUpdate` / `require('nvim-treesitter').install()` usam quando
  -- chamados manualmente. Não instalamos no startup porque (a) o branch main
  -- exige o CLI `tree-sitter` no PATH pra compilar e (b) os .so antigos do
  -- master no diretório do plugin continuam sendo lidos via runtimepath.
  -- Se liga aqui!!!
  -- Pra reinstalar do zero: `:TSInstall lua json ...` depois de `npm i -g tree-sitter-cli`.
  config = function()
    require('nvim-treesitter').setup({})

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft) or ft
        if not lang or lang == '' then return end
        if not vim.treesitter.language.add(lang) then return end

        pcall(vim.treesitter.start, args.buf, lang)
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
