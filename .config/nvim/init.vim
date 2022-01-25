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

Plug 'dracula/vim', {'as': 'dracula'}
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf.vim'

call plug#end()

colorscheme dracula

let g_airline_theme='Dracula'
let g:airline_powerline_fonts = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeShowHidden = 1

" Open a NerdTree if no file is given as CLI argument
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close if the only remaining window is a nerdtree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

autocmd BufReadPre,FileReadPre * :NERDTreeClose

let mapleader=" "

nmap <Leader>s <Plug>(easymotion-s2)
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>
nmap <Leader>e :edit
nmap <Leader>vs :vsplit
nmap <Leader>hs :split
nmap <Leader>l gt
nmap <Leader>L gT
nmap <Leader>nt :tabnew
nmap <Leader>F :Files<CR>

imap jj <Esc>

" Mirror the NERDTree before showing it. This makes it the same on all tabs.
nnoremap <Leader>f :NERDTreeMirror<CR>:NERDTreeFocus<CR>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
