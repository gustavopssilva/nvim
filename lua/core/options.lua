local opt = vim.opt

-- Gerenciamento de Sessões
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Números das Linhas
opt.relativenumber = true
opt.number = true
opt.scrolloff = 10 -- Número mínimo de linhas acima e abaixo do cursor
opt.virtualedit = "onemore" -- para quando acabar as linhas... sera que pega?

-- Abas & Indentação
opt.tabstop = 2
opt.smarttab = true -- para recuar com o shift tab...
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
vim.bo.softtabstop = 2

-- Quebra de Linha
opt.wrap = false

-- Configurações de Busca
opt.ignorecase = true
opt.smartcase = true

-- Habilitar destaque de sintaxe e tipo de arquivo SQL
vim.cmd([[syntax on]])
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.sql",
  callback = function() vim.bo.filetype = "sql" end,
})

-- Ajustando a cor do fundo do highlight se não gostar... pode tirar...
vim.cmd[[highlight Search ctermbg=none guibg=none]]
vim.cmd[[highlight Search guibg=#4b4b4b]] -- Um cinza mais suave

-- -- Highlight ao clicar na palavra
vim.cmd([[
  nnoremap <silent> * :let @/='\V\<'.escape(expand('<cword>'), '/\').'\>'<CR>:set hlsearch<CR>
  nnoremap <silent> # :let @/='\V\<'.escape(expand('<cword>'), '/\').'\>'<CR>:set hlsearch<CR>
]])

-- Cancelar o highlight por similaridade em um doc
vim.api.nvim_set_keymap("n", "<Esc><Esc>", ":noh<CR>", { noremap = true, silent = true })

-- Linha do Cursor
opt.cursorline = true

-- Aparência
-- opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.showmode = false
vim.diagnostic.config {
  float = { border = "rounded" }, -- adicionar borda nos popups de diagnóstico
}

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard = "unnamedplus" -- Isso permite o acesso à área de transferência do sistema

-- Backup
opt.backup = false      -- Não criar arquivos de backup
opt.writebackup = false -- Não criar arquivos de backup
opt.backupcopy = "no" 

-- Desabilitar arquivos de swap
opt.swapfile = false
vim.cmd("filetype on")
vim.cmd("filetype plugin on")
vim.cmd("filetype indent on")

-- Janelas divididas
opt.splitright = true
opt.splitbelow = true
opt.autoread = true -- Se algum outro editor alterar um arquivo que está aberto no vim, ele atualiza

-- Considerar '-' como parte da palavra-chave
opt.iskeyword:append("_")
opt.iskeyword:append("-")

-- Habilitar o mouse no nvim
opt.mouse = "a"

-- Desativar as setas no modo normal(n) e no visual(v):
vim.keymap.set({ 'n', 'v' }, '<Up>', '<Nop>', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<Down>', '<Nop>', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<Left>', '<Nop>', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<Right>', '<Nop>', { noremap = true })


-- Dobramento de código (lazy: só ativa em buffers reais, usando o foldexpr nativo do nvim)
opt.foldlevel = 20
opt.foldenable = true
opt.foldlevelstart = 99
vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function(args)
    if vim.bo[args.buf].buftype ~= "" then return end
    pcall(function()
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end)
  end,
})

-- Desabilita LSP/treesitter em pastas geradas/vendidas — abrir um arquivo dentro
-- delas (inclusive via <C-o>) não vai disparar attach pesado nem indexação.
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  callback = function(args)
    local path = vim.api.nvim_buf_get_name(args.buf)
    if path:match("/dist/")
        or path:match("/node_modules/")
        or path:match("/jspm_packages/")
        or path:match("/build/")
        or path:match("/target/")
        or path:match("/.gradle/") then
      vim.b[args.buf].large_buf = true
      vim.diagnostic.enable(false, { bufnr = args.buf })
      vim.api.nvim_create_autocmd("LspAttach", {
        buffer = args.buf,
        callback = function(ev) vim.lsp.buf_detach_client(ev.buf, ev.data.client_id) end,
      })
    end
  end,
})


opt.conceallevel = 1 -- Para o obsidian.nvim conseguir esconder os links markdown
opt.timeoutlen = 3000 -- Aumentando o tempo entre comandos de 0,05s para 0,3s



