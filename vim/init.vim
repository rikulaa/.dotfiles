"============================================================================
" Plugs
"============================================================================
" {{{
" load all plugins from under .dotfiles
call plug#begin('~/.dotfiles/vim/bundle')

" General usability
Plug 'tpope/vim-commentary'           " Comments
Plug 'tpope/vim-surround'             " Vim Surround plugin
" Plug 'jiangmiao/auto-pairs'           " Autoclose brackets
Plug 'alvan/vim-closetag'             " Close HTML, XML tags
Plug 'junegunn/fzf'                   " fuzzy searc

" Git
Plug 'tpope/vim-fugitive'             " Git utility
Plug 'airblade/vim-gitgutter'         " Show git diffs on sidebar
Plug 'jreybert/vimagit'

" Languages (syntax)
Plug 'posva/vim-vue', {'for': 'vue'}
" Plug 'othree/html5.vim', {'for': 'html'}
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'mxw/vim-jsx', {'for': 'javascript'}
Plug 'alampros/vim-styled-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'jwalton512/vim-blade', {'for': 'blade'}
Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug 'jparise/vim-graphql'

" Languages (autocomplete, goto definition)
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install && composer run-script parse-stubs'}
Plug 'rikulaa/LanguageServer-typescript-neovim/', {'do': 'npm install'}
Plug 'rikulaa/LanguageServer-vue-neovim', {'do': 'npm install'}

" Linting
Plug 'w0rp/ale'
Plug 'editorconfig/editorconfig-vim'

" Intellisense, code completion, goto definition
" Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
" To install php-language-server: cd ./plugin/php-language-server && composer install && composer run-script parse-stubs

" Tests
Plug 'janko-m/vim-test'

" Snippets
Plug 'SirVer/ultisnips'

" Themes
Plug 'tomasiser/vim-code-dark'        "Theme based on visual studio code
Plug 'morhetz/gruvbox'

" Other
Plug 'kristijanhusak/vim-carbon-now-sh'     " Create images from code snippets

call plug#end()            " required
" }}}

"============================================================================
"General
"============================================================================
" {{{
set nocompatible            " no need to support vi
filetype plugin indent on
" Use mouse in normal, visual and insert mode(allows terminal selection while command mode)
set mouse=nvi
set autoread                " Reload files changed outside vim
set encoding=utf-8
set nowrap                  " Disable text wrapping"
set backspace=2             " Allow deleting in insert mode
set scrolloff=8             " keep 8 lines of space above and below the cursor
set splitright              " Split new windows to the right"
set splitbelow              " Split horizontal new windows to the bottom"
" set backupcopy=no          " Doesnt with webpack-dev-server without this (if backups not on)?
set nobackup
set noswapfile              " Dont use swapfiles"
set hidden                  " Can change to another buffer without saving change"
set updatetime=500          " Shows gitgutter signs faster
set timeout                 " Reduce timeout caused by pressin Esc"
set timeoutlen=3000
set ttimeout
set ttimeoutlen=50
set lazyredraw              " "Smootherrrr.??
" set noeol                   " no new line at the end
" set binary                  " No new line at the end

" Affects the visual representation of what happens after you hit <C-x><C-o>
" https://neovim.io/doc/user/insert.html#i_CTRL-X_CTRL-O
" https://neovim.io/doc/user/options.html#'completeopt'
"
" This will show the popup menu even if there's only one match (menuone),
" prevent automatic selection (noselect) and prevent automatic text injection
" into the current line (noinsert).
"
" Copied from https://jacky.wtf/weblog/language-client-and-neovim/
set completeopt=noinsert,menuone,noselect
" }}}

"============================================================================
" UI
"============================================================================
" {{{
set number					" For line numbering
set wildmenu                " Display all matching files when we tab complete
set noruler
set nocursorline
" set relativenumber          " For relative line numbering
syntax enable				" Show syntax
" set termguicolors           " Better colors in terminal, needs support from tmux also

colorscheme gruvbox
set background=dark    " Setting dark mode
" set background=light    " Setting dark mode
set showcmd					" Show command at the bottom
" }}}

"============================================================================
" Spaces & tab
"============================================================================
" {{{
set tabstop=4
set softtabstop=4
set shiftwidth=4			" When indenting with >
set expandtab				" When tabbing, insert (four) spaces
" }}}

"============================================================================
"Searching
"============================================================================
" {{{
set grepprg=rg\ --vimgrep    " Use ripgrep instad of grep"
set ignorecase              " When typing smallcase, search is case-insensitive"
set smartcase               " If any character is UPPER-case, search case-sensitive"
set hlsearch                " Highligth search
set incsearch				" Search as characters are entered
" }}}
"
"
"============================================================================
" Commands
"============================================================================
" {{{
command! Vimrc :e $MYVIMRC
command! Reload :source $MYVIMRC

command! So :source %

command! Bdall silent! :%bdelete
command! Rm :call functions#DeleteAndCloseBuffer()
command! -nargs=1 -complete=file Mv silent :call functions#MoveBuffer(<q-args>)
command! -nargs=1 -complete=file Cp silent :call functions#CopyBuffer(<q-args>)

" From autoload folder
command! ToggleImportsOrientation :call javascript#ToggleImportsOrientation()
command! ToggleFuncParamOrientation :call javascript#ToggleFuncParamOrientation()
command! -range CommentJsx :call javascript#CommentJsx()

" Git: stage current file
command! Ga :!git a %

" Better grep
" - Don't show confirmation after search
" - Open quickfix window immediately
command! -nargs=* -complete=file Grep execute "silent grep! <args>" | copen
"}}}

"============================================================================
" Custom Functions
"============================================================================
" {{{
" }}}

"============================================================================
"Keybindings, custom mappings
"============================================================================
" {{{
let mapleader="\<Space>"	" Use space as leader key

" Buffers
nnoremap <leader>w :w<CR>
nnoremap <leader>q :bd<CR>

"Easier copy and paste from system clipboard
nnoremap <leader>Y "*y
vnoremap <leader>Y "*y
nnoremap <leader>P "+p

"For windows navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Navigation (between tabs)
nnoremap ]t :tabn<CR>
nnoremap [t :tabp<CR>
" Navigation (between buffer)
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>
" Navigation (between quickfix items)
nnoremap ]q :cprev<CR>
nnoremap [q :cnext<CR>

" Navigation (buffers)
" Open buffer with FZF
" https://github.com/junegunn/fzf/wiki/Examples-(vim)
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <leader>b :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>

" Navigation (file explorer)
function! ToggleFileExplorer()
    if &ft ==# "netrw"
        " Netrw is already open
        :Rexplore
    else
        :Explore
    endif
endfunction
nnoremap <leader>e :call ToggleFileExplorer()<CR>

" Global search (patterns)
nnoremap <leader>f :Grep 
" Search the visual selection (as string literal)
vnoremap <leader>f y :Grep -F \"<C-R>"\"

" Global serach (files)
nnoremap <leader>p :call fzf#run({'source': 'rg --files . ', 'window': '30new','sink': 'e'})<CR>
function! SearchFilesByWord(word)
    :execute ":FZF -q " . a:word
endfunction
vnoremap <leader>p :call SearchFilesByWord("<C-r><C-w>")<CR>

" Rename word
nnoremap <Leader>rw :%s/\<<C-r><C-w>\>/
" Rename tag
nnoremap <leader>rt :call functions#ChangeTagName()<cr>
" Rename last search
nnoremap <leader>rs :%s//

" Append character to the end of the line
nnoremap <silent><leader>a :call functions#AppendCharacterToEndOfLine()<cr>

nnoremap <Leader>l :ALEFix<CR>

" Mappings for plugins
nnoremap <leader>G  :Magit<CR>
nmap <leader>ghp <Plug>GitGutterPreviewHunk
nmap <leader>ghs <Plug>GitGutterStageHunk
nmap <Leader>ghu <Plug>GitGutterUndoHunk

let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" Navigate between errors
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nmap <F2> :call LanguageClient_textDocument_rename()<CR>
nmap <silent> <leader>gd :call LanguageClient_textDocument_definition()<CR>

" }}}

" https://www.reddit.com/r/vim/comments/6h0dy7/which_autoclosing_plugin_do_you_use/
" Insert mode mappings (auto expanding)
" inoremap (<CR> (<CR>)<C-c>O
" inoremap (<CR> (<CR>)<C-c>O
" inoremap {<CR> {<CR>}<C-c>O
" inoremap {<CR> {<CR>}<C-c>O
" inoremap [<CR> [<CR>]<C-c>O
" inoremap [<CR> [<CR>]<C-c>O
"
" function! ConditionalPairMap(open, close)
"     let line = getline('.')
"     let col = col('.')
"     if col < col('$') || stridx(line, a:close, col + 1) != -1
"         return a:open
"     else
"         return a:open . a:close . repeat("\<left>", len(a:close))
"     endif
" endfunction
" inoremap <expr> ( ConditionalPairMap('(', ')')
" inoremap <expr> { ConditionalPairMap('{', '}')
" inoremap <expr> [ ConditionalPairMap('[', ']')
"============================================================================
" Autcommands
"============================================================================
" {{{
augroup focusevents
    au!
    " Reload file if file changed
    au FocusGained,BufEnter * :silent! !
augroup end
" }}}
"
augroup dirty_cc_plus_tab_remap
    autocmd!
    " autocmd CmdWinEnter : nnoremap <tab> <c-f>
    autocmd CmdWinEnter * cmap <c-c> <c-c><c-c>
    autocmd CmdWinEnter * noremap <c-c> <c-c><c-c>
    autocmd CmdWinLeave * cmap <c-c> <c-c>
    autocmd CmdWinLeave * noremap <c-c> <c-c>
augroup END
" cmap <c-c> <c-c><c-c>
"============================================================================
" Additional plugin settings
"============================================================================
" {{{
"
" Use LanguageClient for autocompletion source (c-x c-o)
set completefunc=LanguageClient#complete
"
" ======== Git =========
" Gitgutter
let g:gitgutter_terminal_reports_focus=0

" ======== Linting =========
let g:ale_fixers = {
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \'javascript': ['eslint', 'prettier'],
            \'c': ['clang-format'],
            \ 'php': ['phpcbf', 'php_cs_fixer'],
            \}
let g:ale_linters = {
            \'javascript': ['eslint'],
            \ 'php': ['php', 'phpcs', 'phpmd', 'phpstan', 'langserver'],
            \}

" Dont use autoompletion from ale
let g:ale_completion_enabled = 0

" " Dont show error highlights on lines, causes vim to slow down on huge files
let g:ale_set_highlights = 0

let g:ale_php_phpstan_executable='./vendor/bin/phpstan'
let g:ale_php_langserver_executable=$HOME.'/.dotfiles/vim/plugin/php-language-server/vendor/bin/php-language-server.php'

" Don't use language client for linting
" let g:LanguageClient_diagnosticsList = "Location"
let g:LanguageClient_diagnosticsEnable = 0

" Comment arrow functions also
let g:jsdoc_enable_es6 = 1
" ======== Tags =========
" ** Closetag **
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.jsx, *.js, *.blade.php, *.vue"

" Do dont jump to matching tag on another line
let g:AutoPairsMultilineClose = 0

" ======== Snippets =========
" ** UltiSnips **
let g:UltiSnipsSnippetsDir="~/.dotfiles/vim/custom-snippets"
let g:UltiSnipsSnippetDirectories=['custom-snippets']

" ======== UI =========
" ** Nerdtree **
" Fixing the weird symbols instead of folders on some systems
let g:NERDTreeDirArrows=0

let g:carbon_now_sh_options =
\ { 'ln': 'false',
\   'l': 'graphql',
\   't': 'material',
\   'wt': 'sharp',
\   'ds': 'true',
\   'wm': 'false',
\   'wa': 'false,',
\ 'fm': 'Source Code Pro' }
" }}}
"
"
"
fun! CompleteMonths(findstart, base)
    if a:findstart
        " locate the start of the word
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '\a'
            let start -= 1
        endwhile
        return start
    else
        echo getftype(expand('%'))	
        " find months matching with "a:base"
        let res = []
        for m in split("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec")
            if m =~ '^' . a:base
                call add(res, m)
            endif
        endfor
        return res
    endif
endfun

fun! Gft()
    execute ":grep 'snippet'" . g:UltiSnipsSnippetsDir . '/'. &ft . '.snippets'
    for d in getqflist()
       echo bufname(d.bufnr) ':' d.lnum '=' d.text
    endfor
endfun