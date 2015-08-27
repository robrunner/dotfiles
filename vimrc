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
Plugin 'LaTeX-Box-Team/LaTeX-Box' "latex box
Plugin 'easymotion/vim-easymotion' "easymotion
Plugin 'bling/vim-airline' "status bar
Plugin 'ntpeters/vim-better-whitespace' "highlight and strip trailing whitespace
Plugin 'tpope/vim-obsession' "automate sessions
"vundle end

filetype plugin indent on

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

let mapleader=" "

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
vnoremap ß $
inoremap jk <esc>zz
inoremap kj <esc>zz
inoremap JK <esc>:w<CR>zz
inoremap KJ <esc>:w<CR>zz
inoremap <F2> {<CR>}<esc>O
"implement function out of prototype
inoremap <F12> <esc>A<esc>xo{<CR>}<esc>kkVjj"zyA;<esc>j2ddi
nnoremap <Leader>i "zpjo

inoremap (( ();<esc>hi
"--- Ends navigation commands
map <F9> :tabn<CR>
map <F8> :tabp<CR>

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"latexbox start
autocmd BufNewFile,BufRead *.tex set filetype=tex spell spelllang=de_de
nnoremap <Leader>ll :Latexmk<CR>
nnoremap <Leader>lv :LatexView<CR>
nnoremap <Leader>le :LatexErrors<CR>
nnoremap <Leader>lf :LatexFold<CR>
nnoremap <Leader>lt :LatexTOCToggle<CR>

inoremap [[ \begin{
inoremap ]] <esc>o<esc>ml/begin<CR>Nyy'lpkddlcwend<esc>O<esc>:nohl<CR>zzi<space><space><space><space>
"nmap <buffer> <F3> <Plug>LatexChangeEnv
"latexbox end
