set nocompatible
set number
set relativenumber
set numberwidth=1
set mouse=a
syntax enable
set showcmd
set ruler
set encoding=utf-8
set showmatch
set sw=4
set tabstop=4
set expandtab
set smarttab
set shiftwidth=4
set relativenumber
set laststatus=2
set clipboard=unnamed
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
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/emmet-vim'
Plug 'preservim/nerdtree'
Plug 'vifm/vifm.vim'

" Wiki
Plug 'vimwiki/vimwiki'

call plug#end()

colorscheme dracula
let g_airline_theme='Dracula'
let g:airline_powerline_fonts = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" configs
source $HOME/.config/nvim/config/maps.vim
source $HOME/.config/nvim/config/coc.vim
source $HOME/.config/nvim/config/nerdtree.vim
source $HOME/.config/nvim/config/emmet.vim
