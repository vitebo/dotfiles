call plug#begin()
" autocomplete
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jeetsukumaran/vim-buffergator'

" languages
Plug 'sheerun/vim-polyglot'

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

" format
Plug 'editorconfig/editorconfig-vim'

" theme
Plug 'mhartington/oceanic-next'
Plug 'glepnir/oceanic-material'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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

" ctags
set tags=tags

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
set fileencoding=UTF-8
set encoding=UTF-8

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

" git
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>dg :diffget<CR>
nnoremap <leader>dp :diffput<CR>

" Maps Alt-[h,j,k,l] to resizing a window split
map <silent> <A-H> 10<C-w><
map <silent> <A-K> 10<C-W>-
map <silent> <A-J> 10<C-W>+
map <silent> <A-L> 10<C-w>>

" lint
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1
let g:ale_fixers = {
  \'javascript': ['eslint'],
  \'typescript': ['eslint'],
  \'vue': ['eslint'],
\}

" theme
set termguicolors
syntax enable
set background=dark
let g:oceanic_material_allow_bold = 1
let g:oceanic_material_allow_italic = 1
let g:oceanic_material_allow_underline = 1
let g:oceanic_material_allow_undercurl = 1
let g:oceanic_material_allow_reverse = 1
colorscheme oceanic_material

"icons
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:webdevicons_enable_ctrlp = 1

"airline
set guifont=DroidSansMono\ Nerd\ Font\ 11
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline_theme='oceanicnext'
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_ctrlp = 1
let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = 'ƛ'
let g:WebDevIconsUnicodeByteOrderMarkerDefaultSymbol = ''
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1
set statusline=%f\ %{WebDevIconsGetFileTypeSymbol()}\ %h%w%m%r\ %=%(%l,%c%V\ %Y\ %=\ %P%)

" NERDTree
map <C-b><C-b> :NERDTreeToggle<CR>
map <C-b><C-e> :NERDTreeFind<CR>

" Coc
let g:coc_global_extensions = [ 'coc-tsserver' ]
" Use K to show documentation in preview window.
nnoremap <silent> <C-k> :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
nnoremap <c-p> :Files<cr>
nnoremap <c-F> :Ag<cr>
let g:fzf_action = {
  \'ctrl-d': 'bd',
  \'ctrl-t': 'tab split',
  \'ctrl-s': 'split',
  \'ctrl-v': 'vsplit',
\}
