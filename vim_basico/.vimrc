call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'dense-analysis/ale'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Tema --------------------------------------------
let g:gruvbox_contrast_dark = 'hard'
set background=dark
colorscheme gruvbox

" Ativar airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'gruvbox'

" Atalhos --------------------------------------------
let mapleader = " "
" abre o explore
nnoremap <C-q> :NERDTreeToggle<CR>

" procura o arquivo pelo nome
nnoremap <C-p> :Files<CR>
" Procurar pela palavra, tem que ter o rigrep instalado
nnoremap <leader>fg :Rg<space>

" Configurações básicas -----------------------------------------------
set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions
set relativenumber
set number
set scrolloff=4
set tabstop=2
set smarttab
set shiftwidth=2
set expandtab
set autoindent
set softtabstop=2
set nowrap
set ignorecase
set smartcase

highlight Search ctermbg=black guibg=black
highlight Search guibg=#4b4b4b
nnoremap <silent> * :let @/='\V\<'.escape(expand('<cword>'), '/\').'\>'<CR>:set hlsearch<CR>
nnoremap <silent> # :let @/='\V\<'.escape(expand('<cword>'), '/\').'\>'<CR>:set hlsearch<CR>

set termguicolors
set signcolumn=auto
set showmode
set backspace=indent,eol,start
set clipboard=unnamedplus

nnoremap <leader>qq :q<CR>
nnoremap <leader>qa :qa<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>ww :w<CR>

" Formatação manual Google Java Format (opcional)
autocmd FileType java nnoremap <leader>gf :%!java -jar ~/.vim/tools/google-java-format.jar -<CR>

" Snippets --------------------------------------------------------
autocmd FileType java iabbrev <buffer> sout System.out.println("");<Left><Left><Left>


" Programas para instalar----------------------------------------------------------
"cria a pasta na maquina remota
" mkdir -p .vim/autoload
" Envia pra la o vim rc e o plug
" scp -r .vimrc vm_005:/home/ec2-user/
" scp -r .vim/autoload/plug.vim vm_005:/home/ec2-user/.vim/autoload
" - Inatalando o vim plug
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" 
" ou
" cd ~/.vim/bundle
" git clone git://github.com/digitaltoad/vim-pug.git
"
" -------------------------------
"
" Para formatar o json, instala o sudo apt install jq que é um primo do sed e aws
" e usa o comando:
" :%!jq .
"
"O ripgrep ajuda a pesquisar por palavra...
"sudo apt update
"sudo apt install ripgrep
" Usar o comando :Rg

" Para criar o arquivo compactado:
" tar czf vim_backup.tar.gz .vim .vimrc

