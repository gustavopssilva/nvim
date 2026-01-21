local opt = vim.opt

-- Gerenciamento de Sessões
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Números das Linhas
opt.relativenumber = true
opt.number = true
opt.scrolloff = 10 -- Número mínimo de linhas acima e abaixo do cursor

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
vim.cmd([[au BufRead,BufNewFile *.sql set filetype=sql]])

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


-- Dobramento de código
opt.foldlevel = 20
opt.foldmethod = "expr"
opt.foldenable = true
opt.foldlevelstart = 99
opt.foldexpr = "nvim_treesitter#foldexpr()" -- Utiliza o Treesitter para dobrar

-- Movimento das setas
vim.api.nvim_set_keymap("n", "<C-Down>", "<C-d>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Up>", "<C-u>", { noremap = true, silent = true })

-- Mover uma linha ou bloco para baixo com Alt + Seta para baixo
vim.api.nvim_set_keymap("n", "<A-Down>", ":move .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<A-Down>", ":move '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Mover uma linha ou bloco para cima com Alt + Seta para cima
vim.api.nvim_set_keymap("n", "<A-Up>", ":move .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<A-Up>", ":move '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Duplicar uma linha ou bloco para baixo com Alt + Shift + Seta para baixo
vim.api.nvim_set_keymap("n", "<A-S-Down>", ":copy .<CR>==j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<A-S-Down>", ":copy '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Duplicar uma linha ou bloco para cima com Alt + Shift + Seta para cima
vim.api.nvim_set_keymap("n", "<A-S-Up>", ":copy .-1<CR>==k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<A-S-Up>", ":copy '<-2<CR>gv=gv", { noremap = true, silent = true })





