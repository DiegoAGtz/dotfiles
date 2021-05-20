set number
set relativenumber
set numberwidth=1
set mouse=a
syntax enable
set showcmd
set ruler
set encoding=utf-8
set showmatch
set sw=3
set tabstop=3
set expandtab
set smarttab
set shiftwidth=3
set relativenumber
set laststatus=2
set clipboard=unnamedplus
set splitright
set splitbelow
set noshowmode

call plug#begin('~/.config/nvim/Plugged')

" Themes
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'

" Icons
Plug 'ryanoasis/vim-devicons'

" IDE
Plug 'easymotion/vim-easymotion'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'mattn/emmet-vim'

call plug#end()

colorscheme dracula
let g_airline_theme='Dracula'
let g:airline_powerline_fonts = 1

" Maps
let mapleader=" "

" Mapeo modo normal
nmap <Leader>s <Plug>(easymotion-s2)
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>
nmap <Leader>e :edit 
nmap <Leader>vs :vsplit 
nmap <Leader>hs :split 
nmap <Leader>l gt
nmap <Leader>L gT

" Mapeo salir modo insertar
imap jj <Esc>

" Mapeo autocompletar parentesis, llaves, ...
inoremap ( ()<Esc>i
inoremap { {}<Esc>i
inoremap [ []<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i

" configs
source $HOME/.config/nvim/config/coc.vim
source $HOME/.config/nvim/config/nerdtree.vim
source $HOME/.config/nvim/config/emmet.vim
