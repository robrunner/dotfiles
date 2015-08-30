set nocompatible "vim, not vi

"vundle start
filetype off
call vundle#rc()
Plugin 'tpope/vim-fugitive' "git
Plugin 'scrooloose/nerdtree' "nerdtree
Plugin 'Xuyuanp/nerdtree-git-plugin' "git flag support for nerdtree
Plugin 'tpope/vim-surround' "surround
Plugin 'tpope/vim-repeat' "surround support for other plugins
Plugin 'altercation/vim-colors-solarized' "colorscheme
Plugin 'jeffkreeftmeijer/vim-numbertoggle'  "automatically toggle relative and absolute line numbering
Plugin 'kien/ctrlp.vim'  "fuzzy finder
"Plugin 'LaTeX-Box-Team/LaTeX-Box' "latex box
Plugin 'easymotion/vim-easymotion' "easymotion
Plugin 'bling/vim-airline' "status bar
Plugin 'ntpeters/vim-better-whitespace' "highlight and strip trailing whitespace
Plugin 'tpope/vim-obsession' "automate sessions
Plugin 'lervag/vimtex' "latex
Plugin 'Shougo/neocomplete.vim' "neocomplete
Plugin 'Shougo/neosnippet.vim' "neosnippet
Plugin 'Shougo/neosnippet-snippets' "neosnippets
Plugin 'tmux-plugins/vim-tmux' "better tmux.conf editing

filetype plugin indent on
"vundle end

"general
set clipboard=unnamed "p pastes the clipboard
syntax enable  "Enables syntax highlighting for programming languages
set mouse=a  "Allows you to click around the text editor with your mouse to move the cursor
set showmatch "Highlights matching brackets in programming languages
set autoindent  "If you're indented, new lines will also be indented
set smartindent  "Automatically indents lines after opening a bracket in programming languages
set backspace=2  "This makes the backspace key function like it does in other programs.
set tabstop=4  "How much space Vim gives to a tab
set softtabstop=4
set expandtab
set number  "Enables line numbering
set relativenumber
set smarttab  "Improves tabbing
set shiftwidth=4  "Assists code formatting
set t_Co=256
set background=dark
colorscheme solarized
set foldmethod=manual  "Lets you hide sections of code
set cursorline
set lazyredraw
set showmatch
set incsearch
set hlsearch
set ignorecase
set smartcase

"The following commands make the navigation keys work like standard editors
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk

"leader
let mapleader=" "
let maplocalleader=" "

"normal maps
nnoremap j gj
nnoremap k gk
nnoremap <Leader>w :w<CR>zz
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :q!<CR>
nnoremap <Leader>e :tabe 
nnoremap <Leader>m :!clear<CR>:w<CR>:make<CR>
nnoremap <Leader>n :nohl<CR>
nnoremap <Leader>a @
nnoremap ß $
nnoremap dß d$
nnoremap yß y$
nnoremap cß c$

"insert maps
"switch to normal mode with jk
inoremap jk <esc>
inoremap kj <esc>
inoremap JK <esc>:w<CR>zz
inoremap KJ <esc>:w<CR>zz
"draw {} quickly
inoremap <F2> {<CR>}<esc>O
"make first letter of current word upper-/lowercase
inoremap <C-f> <esc>bgUlA
inoremap <C-d> <esc>bgulA
"type (); quickly
inoremap (( ();<esc>hi

"visual maps
vnoremap ß $

"editor controls
map <F9> :tabn<CR>
map <F8> :tabp<CR>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"macros
"implement function out of prototype
inoremap <F12> <esc>A<esc>xo{<CR>}<esc>kkVjj"zyA;<esc>j2ddi
nnoremap <Leader>i "zpjo

"nerdtree start
map <F5> :NERDTreeToggle<CR>
"nerdtree end

"airline start
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

set laststatus=2
"airline end

"latexbox start
"autocmd BufNewFile,BufRead *.tex set filetype=tex spell spelllang=de_de
"nnoremap <Leader>ll :Latexmk<CR>
"nnoremap <Leader>lv :LatexView<CR>
"nnoremap <Leader>le :LatexErrors<CR>
"nnoremap <Leader>lf :LatexFold<CR>
"nnoremap <Leader>lt :LatexTOCToggle<CR>
"
"inoremap [[ \begin{
"inoremap ]] <esc>o<esc>ml/begin<CR>Nyy'lpkddlcwend<esc>O<esc>:nohl<CR>zzi<space><space><space><space>
"nmap <buffer> <F3> <Plug>LatexChangeEnv
"latexbox end

"vimtex start
let g:tex_flavor = 'latex'
let g:vimtex_enabled = 1
let g:vimtex_mappings_enabled = 1
let g:vimtex_fold_enabled = 0

if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.tex =
    \ '\v\\\a*(ref|cite)\a*([^]]*\])?\{([^}]*,)*[^}]*'
"vimtex end

"neocomplete start
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" don't autostart
let g:neocomplete#enable_auto_select = 0
let g:neocomplete#disable_auto_complete=1
"inoremap <expr><Tab> pumvisible() ? "\<C-n>" : neocomplete#start_manual_complete()
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : neocomplete#start_manual_complete('buffer')
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"
"neocomplete end

"neosnippet start
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
"neosnippet end
