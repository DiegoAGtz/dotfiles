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
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            \ Plug 'ryanoasis/vim-devicons'

" IDE
Plug 'easymotion/vim-easymotion'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/emmet-vim'
Plug 'vifm/vifm.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf.vim'

" Wiki
Plug 'vimwiki/vimwiki'

call plug#end()

colorscheme dracula

" configs
source $HOME/.config/nvim/config/maps.vim
source $HOME/.config/nvim/config/vim-airline.vim
source $HOME/.config/nvim/config/coc.vim
source $HOME/.config/nvim/config/nerdtree.vim
source $HOME/.config/nvim/config/emmet.vim
source $HOME/.config/nvim/config/vimwiki.vim
