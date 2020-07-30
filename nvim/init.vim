call plug#begin()
" autocomplete
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'

" finder
Plug 'scrooloose/nerdtree'

" lint
Plug 'dense-analysis/ale'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'

" theme
Plug 'joshdick/onedark.vim'
call plug#end()

" leader key
let mapleader="\<space>"

" commons
set foldmethod=manual
set clipboard=unnamedplus
set backupcopy=yes
set inccommand=split
filetype plugin indent on
set colorcolumn=80,120

" hidden characters
set hidden
set list
set listchars=tab:>-,trail:.,space:.

" enable mouse
set mouse=a

" lines with relative numbers
set number
set relativenumber

" encoding
set fileencoding=utf-8
set encoding=utf-8

" spaces
set expandtab
set tabstop=2
set shiftwidth=2
set backspace=2
set softtabstop=2

" update neovim
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>

" open common files
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<cr>

" escape the terminal
tnoremap <Esc> <C-\><C-n>

" search
set incsearch
set hlsearch
nnoremap <leader>s :nohlsearch<cr>

" Maps Alt-[h,j,k,l] to resizing a window split
map <silent> <A-H> 5<C-w><
map <silent> <A-K> 5<C-W>-
map <silent> <A-J> 5<C-W>+
map <silent> <A-L> 5<C-w>>

" theme
syntax on
set termguicolors
set background=dark
colorscheme onedark

" NERDTree
nnoremap <c-b><c-b> :NERDTreeToggle<cr>
nnoremap <c-b><c-e> :NERDTreeFind<cr>
