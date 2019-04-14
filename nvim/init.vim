call plug#begin()
Plug 'terryma/vim-multiple-cursors'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'roxma/nvim-completion-manager'
Plug 'w0rp/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'honza/vim-snippets'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
Plug 'ap/vim-css-color'
Plug 'ryanoasis/vim-devicons'
Plug 'ekalinin/Dockerfile.vim'
Plug 'JulesWang/css.vim'
Plug 'autozimu/LanguageClient-neovim'
Plug 'nikvdp/ejs-syntax'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

colorscheme Tomorrow-Night
set background=dark

filetype plugin indent on
syntax on

set hidden
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprev<CR>

set mouse=a
set number
set relativenumber
set foldmethod=syntax
set foldlevel=1
set tags=tags
set clipboard=unnamedplus

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
nnoremap <leader>tv :vsplit ~/.tmux.conf<cr>
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<cr>
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>

" NERDTree
nnoremap <s-e> :NERDTreeToggle<cr>
nnoremap <leader>e :NERDTreeFind<cr>
let NERDTreeShowHidden=1

let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
nnoremap <c-p> :Files<cr>
nnoremap <c-f> :Ag<cr>

" Maps Alt-[h,j,k,l] to resizing a window split
map <silent> <A-h> <C-w><
map <silent> <A-k> <C-W>-
map <silent> <A-j> <C-W>+
map <silent> <A-l> <C-w>>
