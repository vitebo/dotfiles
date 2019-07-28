call plug#begin()
Plug 'terryma/vim-multiple-cursors'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'honza/vim-snippets'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ap/vim-css-color'
Plug 'ryanoasis/vim-devicons'
Plug 'ekalinin/Dockerfile.vim'
Plug 'JulesWang/css.vim'
Plug 'autozimu/LanguageClient-neovim'
Plug 'nikvdp/ejs-syntax'
Plug 'morhetz/gruvbox'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path' 
Plug 'mattn/emmet-vim'
Plug 'junegunn/vim-emoji'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'ngmy/vim-rubocop'
Plug 'edkolev/tmuxline.vim'
call plug#end()

syntax enable
set background=dark
colorscheme gruvbox

set colorcolumn=120
set hidden

filetype plugin indent on

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'
let g:tmuxline_preset = {
  \ 'a': '#S',
  \ 'win': '#I #W',
  \ 'cwin': '#I #W',
  \ 'options': { 'status-justify': 'left' }
\}

set mouse=a
set number
set relativenumber
set foldmethod=syntax
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
set backupcopy=yes

set inccommand=split
set incsearch
set hlsearch

let mapleader="\<space>"
nnoremap <leader>tv :vsplit ~/.tmux.conf<cr>
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<cr>
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>
nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprev<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>dg :diffget<CR>
nnoremap <leader>dp :diffput<CR>
tnoremap <Esc> <C-\><C-n>

" NERDTree
nnoremap <s-e> :NERDTreeToggle<cr>
nnoremap <leader>e :NERDTreeFind<cr>
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
nnoremap <c-P> :Files<cr>
nnoremap <c-F> :Ag<cr>

" Maps Alt-[h,j,k,l] to resizing a window split
map <silent> <A-H> <C-w><
map <silent> <A-K> <C-W>-
map <silent> <A-J> <C-W>+
map <silent> <A-L> <C-w>>

" Using Emojis as Git Gutter symbols
if emoji#available()
  let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
  let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
  let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
  let g:gitgutter_sign_modified_removed = emoji#for('collision')
endif

" Emoji completion - <c-x> <c-u>
set completefunc=emoji#complete

