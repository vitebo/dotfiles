call plug#begin()
" monitoring
Plug 'wakatime/vim-wakatime'

" autocomplete
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'

" interface
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" finder
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" languages
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'posva/vim-vue'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'cakebaker/scss-syntax.vim'
Plug 'vim-scripts/svg.vim'
Plug 'othree/html5.vim'
Plug 'digitaltoad/vim-pug'
Plug 'ekalinin/Dockerfile.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'vim-ruby/vim-ruby'
Plug 'nikvdp/ejs-syntax'

" icons
Plug 'junegunn/vim-emoji'
Plug 'ryanoasis/vim-devicons'

" tmux
Plug 'edkolev/tmuxline.vim'

" lint
Plug 'dense-analysis/ale'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
call plug#end()

" leader key
let mapleader="\<space>"

" commons
set foldmethod=manual
set clipboard=unnamedplus
set backupcopy=yes
set inccommand=split
filetype plugin indent on
set colorcolumn=120

" hidden characters
set hidden
set list
set listchars=tab:>-,trail:.
set lcs+=space:.

" theme
syntax enable
set background=dark
colorscheme base16-default-dark
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

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

" ctags
set tags=tags

" update neovim
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>

" navigate between buffers
nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprev<CR>

" open common files
nnoremap <leader>tv :vsplit ~/.tmux.conf<cr>
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<cr>

" git
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>dg :diffget<CR>
nnoremap <leader>dp :diffput<CR>

" escape the terminal
tnoremap <Esc> <C-\><C-n>

" NERDTree
nnoremap <s-e> :NERDTreeToggle<cr>
nnoremap <leader>e :NERDTreeFind<cr>
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" search
set incsearch
set hlsearch
nnoremap <leader>s :nohlsearch<cr>

" fuzzy finder
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
nnoremap <c-P> :Files<cr>
nnoremap <c-F> :Ag<cr>

" Maps Alt-[h,j,k,l] to resizing a window split
map <silent> <A-H> 5<C-w><
map <silent> <A-K> 5<C-W>-
map <silent> <A-J> 5<C-W>+
map <silent> <A-L> 5<C-w>>

" Using Emojis as Git Gutter symbols
if emoji#available()
  let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
  let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
  let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
  let g:gitgutter_sign_modified_removed = emoji#for('collision')
endif

" Emoji completion - <c-x> <c-u>
set completefunc=emoji#complete

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

" tmux
let g:tmuxline_preset = {
  \ 'a': '#S',
  \ 'win': '#I #W',
  \ 'cwin': '#I #W',
  \ 'options': { 'status-justify': 'left' },
  \ 'x': '#(/bin/bash $HOME/.tmux/kube-tmux/kube.tmux)'
\}

" typescript
setlocal indentkeys+=0.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" vue
let g:vue_pre_processors = 'detect_on_enter'

" css
augroup VimCSS3Syntax
  autocmd!
  autocmd FileType css setlocal iskeyword+=-
augroup END

" sass
autocmd FileType scss set iskeyword+=-

" elixir
setlocal formatprg=mix\ format\ -

" ale
let g:ale_linters_explicit = 1
let g:ale_linter_aliases = {'javascript': ['vue', 'javascript']}
let g:ale_linters = {'javascript': ['eslint'], 'ruby': ['rubocop']}

" emmet
let g:user_emmet_leader_key=','

" fzf
let g:fzf_action = {
  \ 'ctrl-d': 'bd',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
\}

nnoremap <leader>gl :Glog! -10 --<CR>
nnoremap <leader>gf :Glog! -10 -- %<CR>
