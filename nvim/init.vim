call plug#begin()
" autocomplete
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'

" finder
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

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
map <silent> <A-H> 10<C-w><
map <silent> <A-K> 10<C-W>-
map <silent> <A-J> 10<C-W>+
map <silent> <A-L> 10<C-w>>

" theme
syntax on
set termguicolors
set background=dark
colorscheme onedark

" NERDTree
map <C-b><C-b> :NERDTreeToggle<CR>
map <C-b><C-e> :NERDTreeFind<CR>

" fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
nnoremap <c-p> :Files<cr>
nnoremap <c-F> :Ag<cr>
let g:fzf_action = {
  \ 'ctrl-d': 'bd',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
\}
