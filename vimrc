set nocompatible              " be iMproved, required
filetype off                  " required for vundle loading plugins correclty

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'		"Vundle


"NERDTree
Plugin 'scrooloose/nerdtree'		"NERDTree

"NERDTree comments
Plugin 'scrooloose/nerdcommenter'

"Emmet
Plugin 'mattn/emmet-vim'			"Emmet

"snipmate
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

"Theme based on visual studio code
Plugin 'tomasiser/vim-code-dark'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

" Put your non-Plugin stuff after this line

"General
set path+=**                "Provide tab-completion for all file-related tasks
set autoread                " Reload files changed outside vim

" UI
set number					"for line numbering
set ruler
syntax enable				"show syntax
set t_Co=256                "enable 256 colors
colorscheme codedark		"theme
set showcmd					"show command at the bottom
set cursorline
set showmatch				"highligth matching [({})]
nnoremap <leader><space> :nohlsearch<CR>	


" Spaces & tab 
set tabstop=4
set softtabstop=4
set shiftwidth=4			"when indenting with >
set expandtab				"when tabbing, insert (four) spaces

"Searching
set incsearch				"search as characters are entered
set hlsearch				"highlight matches

"Keybindings
let mapleader="\<Space>"	"use space as leader key
noremap <Leader>w :update<CR>	"quicksave
noremap <Leader>q :q<CR>        "quit
noremap <Leader>wq :wq<CR>      "write and quit
nmap <leader>ne :NERDTree<cr>   "open nerdtree
nnoremap <C-h> <C-w>h	"for windows navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
