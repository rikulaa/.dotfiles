set nocompatible              " be iMproved, required
filetype off                  " required for vundle loading plugins correclty
"============================================================================
" Plugins
"============================================================================
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
"
Plugin 'VundleVim/Vundle.vim'		"Vundle

" General usability
Plugin 'scrooloose/nerdtree'		    "NERDTree, file-explorer 
Plugin 'tpope/vim-commentary'           " Comments
Plugin 'easymotion/vim-easymotion'      
Plugin 'tpope/vim-surround'             " Vim Surround plugin 

Plugin 'jiangmiao/auto-pairs'           " Autoclose brackets
Plugin 'alvan/vim-closetag'             " Close HTML, XML tags
Plugin 'valloric/matchtagalways'        " Matching xml tag

Plugin 'wincent/terminus'               " Better cursor in terminal vim
Plugin 'christoomey/vim-tmux-navigator' " Navigate vim and tmux panes more easily

" Git
Plugin 'tpope/vim-fugitive'             " Git utility
Plugin 'airblade/vim-gitgutter'         " Show git diffs on sidebar
Plugin 'jreybert/vimagit'

" Languages
Plugin 'gabrielelana/vim-markdown'
Plugin 'othree/xml.vim'
Plugin 'posva/vim-vue'
Plugin 'othree/html5.vim'               " Improved html syntax, indent
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'alampros/vim-styled-jsx'
Plugin 'dsawardekar/wordpress.vim'
Plugin 'jwalton512/vim-blade'
Plugin 'StanAngeloff/php.vim'

Plugin 'junegunn/fzf'                   " fuzzy searc
Plugin 'mattn/emmet-vim'			    "Emmet

" Lint, autocomplete, etc
Plugin 'w0rp/ale'
Plugin 'Shougo/deoplete.nvim'
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'carlitux/deoplete-ternjs'
Plugin 'editorconfig/editorconfig-vim'

" Snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'             " Custom snippets

" Ui
Plugin 'vim-airline/vim-airline'        " Cool statusbar and info
Plugin 'ap/vim-css-color'

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


"============================================================================
"General
"============================================================================
set path+=**                " Provide tab-completion for all file-related tasks
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
set noswapfile              " Dont use swapfiles"

set hidden                  " Can change to another buffer without saving change"


set timeout                 " Reduce timeout caused by pressin Esc"
set ttimeout
set timeoutlen=3000
set ttimeoutlen=50

set ttyfast                   "Smoother scrolling"
" set ttyscroll=3
" set lazyredraw              " "Smootherrrr.??
" set re=1                    
set synmaxcol=200           " dont color lines that are too long
set regexpengine=1          

"============================================================================
" UI
"============================================================================
set number					" For line numbering
set wildmenu                " Display all matching files when we tab complete
set ruler
set nocursorline
" set cursorline              " Shows line where the cursos is
" set relativenumber          " For relative line numbering
syntax enable				" Show syntax
set t_Co=256                " Enable 256 colors
set t_ut=
colorscheme codedark		" Theme
" colorscheme onedark
set showcmd					" Show command at the bottom
" let loaded_matchparen = 1   " Do not show matching bracket
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
"Searching
"============================================================================
set grepprg=rg\ --vimgrep    " Use ripgrep instad of grep"

set ignorecase              " When typing smallcase, search is case-insensitive"
set smartcase               " If any character is UPPER-case, search case-sensitive"
"set showmatch				" Highligth matching [({})]
set hlsearch                " Highligth search 
set incsearch				" Search as characters are entered

"============================================================================
"Keybindings, custom mappings
"============================================================================
let mapleader="\<Space>"	" Use space as leader key

"Easier copy and paste from system clipboard
nnoremap <leader>Y "*y
nnoremap <leader>P "+p

" Save if changes
" noremap <Leader>s :update<CR>	"quicksave
" Toggle nerdtree
nmap <leader>e :NERDTreeToggle<CR>

" Grep from files (current pwd). Seachword is a string, no regex, which allows
" to search for any kind of string inside project
function! Grep(searchword)
    let globs = "-g '!node_modules/' -g '!.git/' -g '!*.lock' -g '!vendor/' -g '!storage/debugbar' -g '!_ide_helper.php' "
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

" FZF
nnoremap <leader>p :FZF<CR>
vmap <leader>p :call SearchFilesByWord("<C-r><C-w>")<CR>

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

nnoremap <leader>l :nohlsearch<CR>	

" git
nnoremap <leader>g  :Gstatus<CR>

" commands
command Vimrc :e ~/.vimrc

command Ga :!git a %
" au BufNewFile,BufRead .vimrc noremap <leader>f :source %
"
" Neovim terminal mapping
" tnoremap <Esc> <C-\><C-n>
" tnoremap <C-[> <C-\><C-n>

function! SearchFilesByWord(word)
    :execute ":FZF -q " . a:word
endfunction

function! GoToDefaultExport()
    let result = search('export default', '', '')
endfunction

function! GoToDefinitionJS()
    let startingLine=getline('.')
    let word = expand("<cword>")

    if matchstr(startingLine, '^import') != 'import'
        :normal gD
        :set hls
    end

    let currentLine=getline('.')
    let importLine = '[import]*' .'[' . word . ']*[from]'
    let splitted = split(currentLine, "'")
    echo splitted

    let targetFilePath = get(splitted, -1 - 1)
    " let targetFilePath = splitted[-1 - 1]

    " try to jump to definition only if file not npm module
    if matchstr(targetFilePath, "^\.") == '.'
        if splitted[0] =~ importLine
            " try to open file with gf
            try 
                :execute "normal /;/\<CR>"
                :normal 3hgf
                call GoToDefaultExport()
            catch
                " try to open file with :e <filename>*
                try
                    let currentFolder =  expand('%:p:h') 
                    :execute ":e " . currentFolder . '/' . targetFilePath . '*'
                    call GoToDefaultExport()
                catch
                    :normal `` 
                endtry
            finally

            endtry
        else
        end
    " else
        " try
        "     " try to open module from node_modules (works only if vim started
        "     " from project root)
        "     :execute ":e ./node_modules/" . targetFilePath . '*'
        " catch
        "     :normal `` 
        " endtry

    end
:endfunction

au BufNewFile,BufRead *.js noremap gd *:call GoToDefinitionJS()<CR>
au BufNewFile,BufRead *.test.js noremap <leader>t :call TestFile()<CR>
au BufNewFile,BufRead *.test.js noremap <leader>T :call Test()<CR>
au BufNewFile,BufRead *.jsx noremap gd :call GoToDefinitionJS()<CR>
au BufNewFile,BufRead *.vue noremap  gd :call GoToDefinitionJS()<CR>

function! GoToDefinitionPHP()
    " Use fzf to searc for class
    let word = expand("<cword>")
    :normal gD
    let currentLine=getline('.')

    " Make basic checks to see if we are using a class
    if word != 'use' && (currentLine =~ '^use' || currentLine =~ 'new' || currentLine =~ '^class')
        call SearchFilesByWord(word)
    elseif currentLine =~ '\\' . word
        let searchWord = get(split(word, ":"), 0)
        call SearchFilesByWord(searchWord)
    else 
        silent
    endif
endfunction

au BufNewFile,BufRead *.php noremap  gd :call GoToDefinitionPHP()<CR>

" Run all test
function! Test()
    let currentFiletype = &filetype
    if currentFiletype =~ 'javascript'
       call OpenSplitTerminal('yarn test')
    else
        echo "No test environment configured"
    endif
endfunction
command Test :call Test()

" Test currentfile
function! TestFile()
    let filePath = expand('%:p')
    let currentFiletype = &filetype

    let currentFiletype = &filetype
    if currentFiletype =~ 'javascript'
       " execute ":!yarn test " . filePath
       let command = 'yarn test ' . filePath
       call OpenSplitTerminal(command)
    else
        echo "No test environment configured"
    endif
endfunction
command TestFile :call TestFile()

" args (command, inVertical, widthOrHeight)
function! OpenSplitTerminal(commands, ...)
    " Check if should open in vertical mode
    let l:isVertical = get(a:, 1)
    " If get optional heigh or width
    let l:heightOrWidth = get(a:, 2, 15)

    let l:openingCommand = isVertical ? 'vnew' : 'new'

    execute ":" . heightOrWidth . openingCommand
    call OpenTerminal(a:commands)
    normal G

    let l:windowDirection = isVertical ? 'h' : 'k'
    execute ":wincmd " . windowDirection
endfunction

function! OpenTerminal(commands)
    call termopen(a:commands)
endfunction

"============================================================================
" Additional plugin settings
"============================================================================


" ======== Linting =========
" ** Ale **
"" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

let g:ale_fixers = {
\'javascript': ['eslint'],
\}
let g:ale_linters = {
\'javascript': ['eslint'],
\'php': [],
\}


" ======== Tags =========
" ** Closetag **
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.jsx, *.js"

" ** MatchTagAlways **
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'javascript.jsx': 1
    \}


" ======== Autocomplete =========
" ** Deoplete **
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

" ======== Snippets =========
" ** UltiSnips **
let g:UltiSnipsSnippetsDir="~/.vim/custom_snippets"
let g:UltiSnipsSnippetDirectories=[g:UltiSnipsSnippetsDir]

" ======== UI =========
" ** Airline **
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" ** Nerdtree **
" Fixing the weird symbols instead of folders on some systems
let g:NERDTreeDirArrows=0
" NERDTress File highlighting
" function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
"  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
"  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
" endfunction

" call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
" call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
" call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
" call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
" call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
" call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
" call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')



" ** Code Dark (them) **
 " call <sid>hi('jsFuncCall', s:cdYellow, {}, 'none', {})
" call <sid>hi('jsExportDefault', s:cdPink, {}, 'none', {})
" call <sid>hi('jsTemplateVar', s:cdLightBlue, {}, 'none', {})
" call <sid>hi('jsTemplateBraces', s:cdBlue, {}, 'none', {})
" call <sid>hi('jsOperator', s:cdBlue, {}, 'none', {})
""
