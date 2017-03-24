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

" CtrlP Fuzzy file finder
Plugin 'kien/ctrlp.vim'

"Emmet
Plugin 'mattn/emmet-vim'			"Emmet

"Necomplete
Plugin 'Shougo/neocomplete.vim'

"snipmate
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

" Autoclose brackets
Plugin 'jiangmiao/auto-pairs'

"HTML, XML Help
Plugin 'alvan/vim-closetag'
"Plugin 'othree/xml.vim'

"jsx syntax
Plugin 'chemzqm/vim-jsx-improve'
"Plugin 'pangloss/vim-javascript'
"Plugin 'mxw/vim-jsx'

" Vim Surround plugin
Plugin 'tpope/vim-surround'

"Vim airline
Plugin 'vim-airline/vim-airline'

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



"****************************************************************************
"General
"****************************************************************************
"set path+=**                " Provide tab-completion for all file-related tasks
set autoread                " Reload files changed outside vim
autocmd vimenter * NERDTree " Open NERDTree when opening vim
set encoding=utf-8
set nowrap                  " Disable text wrapping"
set backupcopy=yes          " Doesnt with webpack-dev-server without this?
" Enable neocomplete
let g:neocomplete#enable_at_startup = 1
" filenames like *.xml, *.html, *.xhtml, ...
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.jsx"
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['javascript'] = 'javascript,javascript.es6.react'

"****************************************************************************
" UI
"****************************************************************************
set number					" For line numbering
set wildmenu                " Display all matching files when we tab complete
set ruler
set relativenumber          " For relative line numbering
syntax enable				" Show syntax
set t_Co=256                " Enable 256 colors
colorscheme codedark		" Theme
set showcmd					" Show command at the bottom
set cursorline              " Shows line where the cursos is
set showmatch				" Highligth matching [({})]
set laststatus=2            " For Airline to show itself on startup"
set sidescroll=1            " Better side scrolling"
nnoremap <leader><space> :nohlsearch<CR>	

" Fixing the weird symbols instead of folders on some systems
let g:NERDTreeDirArrows=0
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')


"****************************************************************************
" Spaces & tab 
"****************************************************************************
set tabstop=4
set softtabstop=4
set shiftwidth=4			" When indenting with >
set expandtab				" When tabbing, insert (four) spaces


"****************************************************************************
"Searching
"****************************************************************************
set incsearch				" Search as characters are entered
set hlsearch				" Highlight matches
" Ignore these folders when searching with ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

"****************************************************************************
"Keybindings
"****************************************************************************
let mapleader="\<Space>"	" Use space as leader key
noremap <Leader>w :update<CR>	"quicksave
noremap <Leader>q :q<CR>        "quit
"noremap <Leader>wq :wq<CR>      "write and quit
nmap <leader>ne :NERDTree<cr>   "open nerdtree

"For windows navigation
nnoremap <C-h> <C-w>h	
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Tab navigation like VScode/browser 
" THIS DOESNT WORK IN EVERY TERMINAL.
" Works in gvim though
nnoremap <C-S-Tab> :tabp<CR>
nnoremap <C-Tab>   :tabn<CR>
