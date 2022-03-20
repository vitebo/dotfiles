syntax on

filetype plugin indent on

let mapleader = " "

highlight ColorColumn ctermbg=0 guibg=lightgrey

set background=dark
set backspace=2
set backupcopy=yes
set clipboard=unnamedplus
set colorcolumn=80,120
set encoding=UTF-8
set expandtab
set fileencoding=UTF-8
set foldmethod=manual
set hidden
set hlsearch
set inccommand=split
set incsearch
set list
set listchars=tab:>-,trail:.,space:.
set mouse=a
set nobackup
set noerrorbells
set noswapfile
set nowrap
set nu
set number
set relativenumber
set shiftwidth=2
set smartcase
set smartindent
set softtabstop=2
set tabstop=2
set tags=tags
set termguicolors
set undodir=~/.vim/undodir
set undofile

call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'ayu-theme/ayu-vim'
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'lyuts/vim-rtags'
Plug 'mattn/emmet-vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'vim-utils/vim-man'

call plug#end()

let ayucolor="mirage"
colorscheme ayu

map <silent> <A-H> 10<C-w><
map <silent> <A-K> 10<C-W>-
map <silent> <A-J> 10<C-W>+
map <silent> <A-L> 10<C-w>>
map <C-b><C-b> :NERDTreeToggle<CR>
map <C-b><C-e> :NERDTreeFind<CR>
map <C-w>t :vsplit term://zsh<CR>

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<cr>
nnoremap <leader>s :nohlsearch<cr>
nnoremap <c-p> :Files<cr>
nnoremap <c-F> :Ag<cr>

tnoremap <Esc> <C-\><C-n>

" Ale
let g:ale_fix_on_save = 1
let g:ale_fixers = {
  \'javascript': ['eslint'],
  \'typescript': ['eslint'],
  \'vue': ['eslint', 'stylelint'],
\}

" NERDTree
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
let g:fzf_action = {
  \'ctrl-d': 'bd',
  \'ctrl-t': 'tab split',
  \'ctrl-s': 'split',
  \'ctrl-v': 'vsplit',
\}
