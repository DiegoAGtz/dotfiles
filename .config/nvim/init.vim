set hidden
set nobackup
set nowritebackup
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
Plug 'preservim/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf.vim'

call plug#end()

colorscheme dracula

" configs
source $HOME/.config/nvim/config/maps.vim
source $HOME/.config/nvim/config/vim-airline.vim
source $HOME/.config/nvim/config/nerdtree.vim
