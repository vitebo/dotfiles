call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'terryma/vim-multiple-cursors'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'roxma/nvim-completion-manager'
Plug 'w0rp/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'honza/vim-snippets'
call plug#end()

colorscheme gruvbox
set background=dark

filetype plugin indent on
syntax on

set hidden
set mouse=a
set number
set relativenumber

set expandtab
set tabstop=2
set shiftwidth=2
set backspace=2
set softtabstop=2

set fileencoding=utf-8
set encoding=utf-8

set list
set listchars=tab:>-,trail:.
set lcs+=space:.

set inccommand=split
set incsearch
set hlsearch

let mapleader="\<space>"
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<cr>
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>

nnoremap <c-p> :Files<cr>
nnoremap <c-f> :Ag<cr>
