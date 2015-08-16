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
Plugin 'scrooloose/syntastic' "syntax checking
"vundle end

filetype plugin indent on

"nerdtree start
map <F5> :NERDTreeToggle<CR>
"nerdtree end

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
set  t_Co=256
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
"--- The following commands make the navigation keys work like standard editors
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk

let mapleader=" "

vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

nmap <Leader><Leader> V

nnoremap j gj
nnoremap k gk
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :q!<CR>
nnoremap <Leader>e :tabe 
nnoremap <Leader>m :!clear<CR>:w<CR>:make<CR>
nnoremap <Leader>n :nohl<CR>
nnoremap <Leader>a @
nnoremap ß $
nnoremap dß d$
nnoremap cß c$
vnoremap ß $
inoremap jk <esc>
inoremap kj <esc>
inoremap JK <esc>:w<CR>
inoremap KJ <esc>:w<CR>
inoremap <F2> {<CR>}<esc>O
"implement function out of prototype
inoremap <F12> <esc>A<esc>xo{<CR>}<esc>kkVjj"zyA;<esc>j2ddi
nnoremap <Leader>i "zpjo

inoremap (( ();<esc>hi
nnoremap <leader>s :mksession<CR>
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

imap <buffer> [[ \begin{
imap <buffer> ]] <Plug>LatexCloseCurEnv
nmap <buffer> <F3> <Plug>LatexChangeEnv
"latexbox end
