"============================================================================
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'		"Vundle

Plugin 'scrooloose/nerdtree'		    "NERDTree, file-explorer 
Plugin 'tpope/vim-commentary'           " Comments
Plugin 'junegunn/fzf'                   " fuzzy searc
Plugin 'mattn/emmet-vim'			    "Emmet
Plugin 'easymotion/vim-easymotion'      
" needs ruby
" Plugin 'wincent/command-t'

" Plugin 'vim-syntastic/syntastic'        "Syntastic for checking code for errors
Plugin 'w0rp/ale'
" Plugin 'mtscout6/syntastic-local-eslint.vim'
Plugin 'othree/html5.vim'               " Improved html syntax, indent
Plugin 'MarcWeber/vim-addon-mw-utils'   " Required for snipmate
Plugin 'tomtom/tlib_vim'                " Required for snipmate
Plugin 'garbas/vim-snipmate'            " Required for snipmate
Plugin 'honza/vim-snippets'             " Custom snippets
Plugin 'jiangmiao/auto-pairs'           " Autoclose brackets
Plugin 'alvan/vim-closetag'             " Close HTML, XML tags
Plugin 'valloric/matchtagalways'        " Matching xml tag

Plugin 'gabrielelana/vim-markdown'
Plugin 'othree/xml.vim'
Plugin 'posva/vim-vue'
" Plugin 'moll/vim-node'
" Plugin 'moll/vim-node'
" Plugin 'chemzqm/vim-jsx-improve'        " Improve jsx syntax
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

Plugin 'tpope/vim-surround'             " Vim Surround plugin 
Plugin 'tpope/vim-fugitive'             " Git utility
Plugin 'airblade/vim-gitgutter'         " Show git diffs on sidebar
Plugin 'vim-airline/vim-airline'        " Cool statusbar and info

Plugin 'editorconfig/editorconfig-vim'
" Plugin 'sgur/vim-editorconfig'
"
Plugin 'wincent/terminus'
Plugin 'christoomey/vim-tmux-navigator'

Plugin 'ap/vim-css-color'

Plugin 'dsawardekar/wordpress.vim'
Plugin 'jwalton512/vim-blade'
Plugin 'StanAngeloff/php.vim'


" Testing neodeplte
Plugin 'Shougo/deoplete.nvim'
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'carlitux/deoplete-ternjs'

" Themes
Plugin 'tomasiser/vim-code-dark'        "Theme based on visual studio code
Plugin 'joshdick/onedark.vim'


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
"
"
"============================================================================
"Plugin settings
"============================================================================
"Syntastic
set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%=

" map <leader>s <Plug>(easymotion-s)
" nnoremap <leader>s <Plug>(easymotion-s)

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0


" FIND FILE IN PARETN
" function! FindFileInParent(what, where) abort 
"     let old_suffixesadd = &suffixesadd
"     let &suffixesadd = ''
"     let file = findfile(a:what, escape(a:where, ' ,') . ';')
"     let &suffixesadd = old_suffixesadd
"     return file
" endfunction

" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_javascript_eslint_exe = 'eslint'

" JS - prefer project-scope node_modules linters to global linters
" http://nunes.io/notes/guide/vim-how-to-setup-eslint/

" function CheckJavaScriptLinter(filepath, linter)
"     if exists('b:syntastic_checkers')
"         return
"     endif
"     if filereadable(a:filepath)
"         let b:syntastic_checkers = [a:linter]
"         let {'b:syntastic_' . a:linter . '_exec'} = a:filepath
"     endif
" endfunction

" function SetupJavaScriptLinter()
"     let l:current_folder = expand('%:p:h')
"     let l:bin_folder = fnamemodify(FindFileInParent('package.json', l:current_folder), ':h')
"     let l:bin_folder = l:bin_folder . '/node_modules/.bin/'
"     call CheckJavaScriptLinter(l:bin_folder . 'eslint', 'eslint')
" endfunction

" autocmd FileType javascript call SetupJavaScriptLinter()


let g:ale_fixers = {
\'javascript': ['eslint'],
\}
let g:ale_linters = {
\'javascript': ['eslint'],
\'php': [],
\}



let g:jsx_ext_required = 0 " Allow JSX in normal JS files

"filenames like *.xml, *.html, *.xhtml, ...
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.jsx, *.js"


let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'javascript.jsx': 1
    \}

" Enable deocomplete
let g:deoplete#enable_at_startup = 1

let g:deoplete#sources#ternjs#timeout = 1

" Whether to include the types of the completions in the result data. Default: 0
let g:deoplete#sources#ternjs#types = 1

" Whether to include the distance (in scopes for variables, in prototypes for 
" properties) between the completions and the origin position in the result 
" data. Default: 0
let g:deoplete#sources#ternjs#depths = 1

" Whether to include documentation strings (if found) in the result data.
" Default: 0
" let g:deoplete#sources#ternjs#docs = 1

" When on, only completions that match the current word at the given point will
" be returned. Turn this off to get all results, so that you can filter on the 
" client side. Default: 1
let g:deoplete#sources#ternjs#filter = 0

" Whether to use a case-insensitive compare between the current word and 
" potential completions. Default 0
let g:deoplete#sources#ternjs#case_insensitive = 1

" When completing a property and no completions are found, Tern will use some 
" heuristics to try and return some properties anyway. Set this to 0 to 
" turn that off. Default: 1
let g:deoplete#sources#ternjs#guess = 1

" Determines whether the result set will be sorted. Default: 1
let g:deoplete#sources#ternjs#sort = 0

" When disabled, only the text before the given position is considered part of 
" the word. When enabled (the default), the whole variable name that the cursor
" is on will be included. Default: 1
let g:deoplete#sources#ternjs#expand_word_forward = 0

" Whether to ignore the properties of Object.prototype unless they have been 
" spelled out by at least two characters. Default: 1
let g:deoplete#sources#ternjs#omit_object_prototype = 0

" Whether to include JavaScript keywords when completing something that is not 
" a property. Default: 0
let g:deoplete#sources#ternjs#include_keywords = 1

" If completions should be returned when inside a literal. Default: 1
let g:deoplete#sources#ternjs#in_literal = 0


"Add extra filetypes
let g:deoplete#sources#ternjs#filetypes = [
            \ 'jsx',
            \ 'javascript.jsx',
            \ 'vue',
            \ '...'
            \ ]


let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['javascript'] = 'javascript,javascript.es6.react'

" Dont run linter on text change
" let g:ale_lint_on_text_changed = 'never'

" Ignore these folders when searching with ctrlp
" let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Custom separators
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Fixing the weird symbols instead of folders on some systems
let g:NERDTreeDirArrows=0
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.='. a:extension .'$#'
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


"============================================================================
"General
"============================================================================
filetype plugin indent on   " Required for omnifunc
set path+===                " Provide tab-completion for all file-related tasks
set autoread                " Reload files changed outside vim
"autocmd vimenter = NERDTree " Open NERDTree when opening vim
set encoding=utf-8
set nowrap                  " Disable text wrapping"
set backspace=2             " Allow deleting in insert mode 
set scrolloff=8             " keep 8 lines of space above and below the cursor
set splitright              " Split new windows to the right"
set splitbelow              " Split horizontal new windows to the bottom"
set backupcopy=yes          " Doesnt with webpack-dev-server without this?
set backupdir=~/.vim/backup// " Move all swap files to this location"
set directory=~/.vim/swp//

" Reduce timeout caused by pressin Esc"
set timeout
set ttimeout
set timeoutlen=3000
set ttimeoutlen=50

" set ttyfast                  Smoother scrolling"
" set ttyscroll=3
set lazyredraw              " "Smootherrrr.??
" set re=1                    
set synmaxcol=200           " dont color lines that are too long
set regexpengine=1          


"============================================================================
"Files, buffers
" allows to switch from unsaved buffer
set hidden
"============================================================================

"============================================================================
"Searching
"============================================================================
set grepprg=rg\ --vimgrep    " Use ripgrep instad of grep"

set ignorecase              " When typing smallcase, search is case-insensitive"
set smartcase               " If any character is UPPER-case, search case-sensitive"
"set showmatch				" Highligth matching [({})]
set hlsearch                " Highligth search 
set incsearch				" Search as characters are entered


"============================================================================
" UI
"============================================================================
" set number					" For line numbering
set wildmenu                " Display all matching files when we tab complete
set ruler
set nocursorline
" set relativenumber          " For relative line numbering
syntax enable				" Show syntax
set t_Co=256                " Enable 256 colors
set t_ut=
colorscheme codedark		" Theme
" colorscheme onedark
set showcmd					" Show command at the bottom
set cursorline              " Shows line where the cursos is
let loaded_matchparen = 1   " Do not show matching bracket
" set laststatus=1            " For Airline to show itself on startup"
" set laststatus=2            " For Airline to show itself on startup"
set sidescroll=1            " Better side scrolling"


"============================================================================
" Spaces & tab 
"============================================================================
set tabstop=4
set softtabstop=4
set shiftwidth=4			" When indenting with >
set expandtab				" When tabbing, insert (four) spaces

"============================================================================
"Keybindings
"============================================================================
let mapleader="\<Space>"	" Use space as leader key

"Easier copy and paste from system clipboard
noremap <leader>y "+y   
" nnoremap <leader>p "+p

" Save if changes
" noremap <Leader>s :update<CR>	"quicksave
" Toggle nerdtree
nmap <leader>e :NERDTreeToggle<CR>

" nnoremap <leader>F :grep -i -g "!flow-typed" -g "!node_modules" -g "!vim/*"
" nnoremap <leader>F :grep -i -uu 
function! Grep(searchword)
    let globs = "-g '!node_modules/' -g '!.git/' -g '!*.lock' -g '!vendor/' -g '!storage/debugbar' "
    :execute "grep! -S --hidden ". globs . "-F " . "'" . a:searchword . "'"
    :execute "cw"
endfunction

function! GrepFromFiles(selection) 
    let name = input('Search for: ', a:selection)
    if name != ""
        :execute ":call Grep(name)"
    endif

:endfunction
nnoremap <leader>f :call GrepFromFiles("")<CR>
vmap <leader>f y :call GrepFromFiles(@")<CR>
" nnoremap <leader>F :grep -R --exclude-dir=node_modules 

" FZF
nnoremap <leader>p :FZF<CR>

" List buffers
nnoremap <leader>b :ls<CR>:b

nnoremap <C-`> :term<CR>
"For windows navigation
" nnoremap <C-h> <C-w>h	
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" Move to the previous buffer with 
nnoremap <S-Tab>  :bp<CR>
" Move to the next buffer with 
nnoremap <Tab>    :bn<CR>
" Close buffer
nnoremap <leader>q  :bd<CR>

nnoremap <leader><space> :nohlsearch<CR>	

" git
nnoremap <leader>g  :Gstatus<CR>

inoremap <>> <ESC>=jA
inoremap <C-=> <ESC>=jA

" commands
command Vimrc :e ~/.vimrc
" au BufNewFile,BufRead .vimrc noremap <leader>f :source %
"
" Neovim terminal mapping
" tnoremap <Esc> <C-\><C-n>
" tnoremap <C-[> <C-\><C-n>

" More colors for code dark
 " call <sid>hi('jsFuncCall', s:cdYellow, {}, 'none', {})
" call <sid>hi('jsExportDefault', s:cdPink, {}, 'none', {})
" call <sid>hi('jsTemplateVar', s:cdLightBlue, {}, 'none', {})
" call <sid>hi('jsTemplateBraces', s:cdBlue, {}, 'none', {})
" call <sid>hi('jsOperator', s:cdBlue, {}, 'none', {})
""

function! GoToDefinition()
    let word = expand("<cword>")
    :normal gD
    :set hls
    let currentLine=getline('.')
    let importLine = '[import]*' .'[' . word . ']*[from]'
    let splitted = split(currentLine, "'")
    if splitted[0] =~ importLine
        try 
            :execute "normal /;/\<CR>"
            :normal 3hgf
        catch
            :normal `` 
        finally

        endtry

    else
    end
:endfunction

au BufNewFile,BufRead *.js noremap gd *:call GoToDefinition()<CR>
au BufNewFile,BufRead *.jsx noremap gd :call GoToDefinition()<CR>
au BufNewFile,BufRead *.vue noremap  gd :call GoToDefinition()<CR>
" au BufNewFile,BufRead *.js noremap gf $3hgf
" au BufNewFile,BufRead *.jsx noremap gf $3hgf
" au BufNewFile,BufRead *.vue noremap  gf $3hgf
" nmap <leader>f $3hgf....
"
"
" " Performance improvments
if has("mac")
  set nocursorline

  if exists("+relativenumber")
    set norelativenumber
    set number
  endif

  set foldlevel=0
  set foldmethod=manual
endif

