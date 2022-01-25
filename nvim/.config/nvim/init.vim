"============================================================================
" Plugs START
"============================================================================
" {{{
call plug#begin('$HOME/.config/nvim/bundle')

" General usability
Plug 'tpope/vim-commentary'           " Comments
Plug 'tpope/vim-surround'             " Vim Surround plugin
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-abolish'            " For converting name cases
Plug 'neovim/nvim-lspconfig'
Plug 'sosmo/vim-macrorepeat'
Plug 'nvim-lua/plenary.nvim' " For null-ls
Plug 'jose-elias-alvarez/null-ls.nvim', { 'branch': 'main' }
" Plug 'folke/which-key.nvim'
Plug 'stevearc/aerial.nvim'
Plug 'mtikekar/nvim-send-to-term'
Plug 'kevinhwang91/nvim-bqf', { 'branch': 'main' }
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
" Plug 'hrsh7th/nvim-cmp', { 'branch': 'main' }
" Plug 'hrsh7th/cmp-nvim-lsp', { 'branch': 'main' }
" Plug 'hrsh7th/cmp-buffer', { 'branch': 'main' }

" Plug 'Raimondi/delimitMate'
" Plug 'jiangmiao/auto-pairs'
Plug 'rikulaa/vim-yamenu'
Plug 'chrisbra/csv.vim'

" Close HTML, XML tags
Plug 'alvan/vim-closetag'

" Fuzzy file search
if (executable('fzf'))
    Plug 'junegunn/fzf'
endif

" Git
if (executable('git'))
    Plug 'tpope/vim-fugitive'             " Git utility
    Plug 'airblade/vim-gitgutter'         " Show git diffs on sidebar
    Plug 'jreybert/vimagit'
endif

" Languages (syntax etc)
" JS
Plug 'posva/vim-vue', {'for': 'vue'}
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'alampros/vim-styled-jsx'
Plug 'leafgarland/typescript-vim' " Syntax for ts
Plug 'heavenshell/vim-jsdoc'
Plug 'leafOfTree/vim-vue-plugin'


" Liquid
Plug 'tpope/vim-liquid'

" PHP
Plug 'jwalton512/vim-blade', {'for': 'blade'}
Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug 'arnaud-lb/vim-php-namespace'
Plug 'vim-scripts/PDV--phpDocumentor-for-Vim'
Plug 'lumiliet/vim-twig'

" Elixir
Plug 'elixir-editors/vim-elixir'

" Other
Plug 'tpope/vim-markdown'
Plug 'jparise/vim-graphql'
Plug 'tpope/vim-dadbod'


Plug 'editorconfig/editorconfig-vim'

" Tests
Plug 'janko-m/vim-test'

" Snippets
if (has("python3") && (has('nvim') || v:version > 704))
    Plug 'SirVer/ultisnips'
endif

" Themes
Plug 'tomasiser/vim-code-dark'        "Theme based on visual studio code
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'
Plug 'endel/vim-github-colorscheme'
Plug 'arcticicestudio/nord-vim'
Plug 'https://gitlab.com/gi1242/vim-emoji-ab'

call plug#end()            " required
packadd cfilter
" }}}
"============================================================================
" Plugs END
"============================================================================

"============================================================================
"General START
"============================================================================
" {{{
set nocompatible            " no need to support vi
filetype plugin indent on
" Use mouse in normal, visual and insert mode(allows terminal selection while command mode)
set mouse=nvi
set autoread                " Reload files changed outside vim
set nowrap                  " Disable text wrapping"
set backspace=2             " Allow deleting in insert mode
set backspace=indent,eol,start " Proper backspace behavior.
set scrolloff=8             " keep 8 lines of space above and below the cursor
set splitright              " Split new windows to the right"
set splitbelow              " Split horizontal new windows to the bottom"
" set backupcopy=no          " Doesnt with webpack-dev-server without this (if backups not on)?
set undofile
set nobackup
set noswapfile              " Dont use swapfiles"
set hidden                  " Can change to another buffer without saving change"
set updatetime=500          " Shows gitgutter signs faster
set timeout                 " Reduce timeout caused by pressin Esc"
set timeoutlen=1000
set ttimeout
set ttimeoutlen=50
set lazyredraw              " E.g do not draw screen between macros, makes them run faster
set spelllang=en
set foldmethod=manual
if (has('nvim'))
    set inccommand=split
endif

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

" UI settings
set number					" For line numbering
set wildmenu                " Display all matching files when we tab complete
set noruler
set nocursorline
syntax enable				" Show syntax
set termguicolors           " Better colors in terminal, needs support from tmux also

" colorscheme gruvbox
colorscheme nord
let iterm_profile = $ITERM_PROFILE
if iterm_profile == "Light"
    set background=light        " Set light background explicitely
    " Just override the as well (so it won't look horrible)
    colorscheme gruvbox
else
    set background=dark
endif
set showcmd					" Show command at the bottom

" Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4			" When indenting with >
set expandtab				" When tabbing, insert (four) spaces

" Searching
if executable('rg')
    set grepprg=rg\ --vimgrep    " Use ripgrep instad of grep"
endif
set ignorecase              " When typing smallcase, search is case-insensitive"
set smartcase               " If any character is UPPER-case, search case-sensitive"
set hlsearch                " Highligth search
set incsearch				" Search as characters are entered
" set cursorline
" }}}
"============================================================================
"General END
"============================================================================


"============================================================================
" Commands START
"============================================================================
" {{{
command! Vimrc :e $MYVIMRC
command! Eft :execute 'e ~/.config/nvim/after/ftplugin/'.&filetype.'.vim'
command! Esy :execute 'e ~/.config/nvim/after/syntax/'.&filetype.'.vim'
command! Reload :source $MYVIMRC

command! -nargs=? Web :call websearch#Search(<q-args>)

command! So :source %

command! Bdall silent! :%bdelete
command! Rm :call functions#DeleteAndCloseBuffer()
command! -nargs=1 -complete=file Mv silent :call functions#MoveBuffer(<q-args>)
command! -nargs=1 -complete=file Cp silent :call functions#CopyBuffer(<q-args>)

command CopyPath let @+ = expand('%:p')
command CP CopyPath
command CopyName let @+ = expand('%')
command CN CopyName
command CopyNameBase let @+ = expand('%:r')
command CNB CopyNameBase
command CopyDir let @+ = expand('%:h')

" Git: stage current file
command! Ga :!git a %

command! Foldopen normal zR
command! Foldclose normal zM

" Better grep (https://noahfrederick.com/log/vim-streamlining-grep
" - Don't show confirmation after search by using silent
" - Open quickfix window immediately
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep!'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep!' : 'lgrep'

" Command for resyncing screen
command! ResyncScreen :syntax sync fromstart<cr>:redraw!<cr>

" Command for quickly checking up cheatsheets
command! -nargs=1 -bang -complete=customlist,EditCheatsheetComplete
            \ Cheat 15split<bang> <args>
function! EditCheatsheetComplete(A,L,P)
    return split(globpath('~/.dotfiles/cheatsheets/', a:A.'*'), "\n")
endfun

command! MacroRepeatNormal :call macrorepeat#MacroRepeatNormal()
command! -range MacroRepeatVisual :call macrorepeat#MacroRepeatVisual()

function! Repl(cmd)
    execute 'vsplit term://'.a:cmd
    :SendHere
    normal G
    wincmd p
endfunction

command! -nargs=? Repl :call Repl(<q-args>)

iabbrev date@ <Esc>:let @+ = strftime("%Y-%m-%d")"<cr>"+pa
iabbrev time@ <Esc>:let @+ = strftime("%T")"<cr>"+pa
iabbrev time@ <Esc>:read !iso-time<cr>kJA
iabbrev pwd@ <Esc>:read !pwd<cr>kJA
iabbrev pwd@ <Esc>:read !pwd<cr>kJA
iabbrev file@ <Esc>:CopyName<CR>"+pA
iabbrev directory@ <Esc>:CopyDir<CR>"+pA

iabbrev :smiley: 😄

"}}}
"============================================================================
" Commands END
"============================================================================

"============================================================================
"Keybindings, custom mappings START
"============================================================================
" {{{
let mapleader="\<Space>"	" Use space as leader key

nnoremap <silent> Q <nop>

" Jumplist mutations. Set the previous context marker before jumping more
" than 5 lines
nnoremap <expr> k (v:count > 5 ? "m'" . v:count :  "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count :  "") . 'j'

nnoremap <leader>; :
vnoremap <leader>; :
" Make Y behave like rest of the gang
nnoremap Y y$
" Windows
nnoremap <leader>w <C-W>

" Remove search highlihgt
nmap <Esc> :noh<CR>

" Buffers
" nnoremap <leader>w :w<CR>
nnoremap <leader>q :bd<CR>
" Write buffer|file
" Acronym: Buffer|file -> Write
nnoremap <leader>bw :w<CR>
nnoremap <leader>bd :bd<CR>
nnoremap <leader>fw :w<CR>
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

nnoremap <silent> <leader>, :call fzf#run(fzf#wrap({
            \   'source':  reverse(<sid>buflist()),
            \   'sink':    function('<sid>bufopen'),
            \ }))<CR>

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
nnoremap ]t :tabnext<CR>
nnoremap [t :tabprev<CR>
" Navigation (between quickfix items)
nnoremap ]q :cnext<CR>
nnoremap [q :cprev<CR>
" Navigation (between arglist items)
nnoremap ]a :next<CR>
nnoremap [a :prev<CR>

" Navigate between errors
nmap <silent> [e :lua vim.lsp.diagnostic.goto_prev()<CR>
nmap <silent> ]e :lua vim.lsp.diagnostic.goto_next()<CR>
nmap <silent> gE :lua vim.lsp.diagnostic.goto_prev()<CR>
nmap <silent> ge :lua vim.lsp.diagnostic.goto_next()<CR>

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Search with current selection
xnoremap * y/<C-R>"<CR>

" Center the screen after when going through search results
nnoremap <silent> n nzz
nnoremap <silent> N Nzz

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
nnoremap <leader>/ :silent grep! 
" Search the visual selection (as string literal)
function! StringLiteralSearch(str)
    let _str = substitute(escape(a:str, " \t*?[{`$\\%#'\"|!<("), "\n", "$'\\\\n'", "g")
    execute ":silent grep! -F " . _str
endf
vnoremap <leader>/ y :call StringLiteralSearch(@")

" WIP SaveVisualRegionEdit START
function! SaveVisualRegionEdit() abort
    normal ggyG
    let @" = substitute(@", "^\n", "", "g")
    let @" = substitute(@", "\n$", "", "g")
    " let @" = substitute(@", "^\s", "", "g")
    execute ":bd"
    normal gv"0p
endfunction

function! EditVisualRegion(str) abort
    " Define the size of the floating window
    let windowWidth = nvim_win_get_width(0)
    let width = l:windowWidth - (l:windowWidth / 4)
    let windowHeight = nvim_win_get_height(0)
    let height = l:windowHeight - (l:windowHeight / 4)

    " Create the scratch buffer displayed in the floating window
    let buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(buf, 0, -1, v:true, split(a:str, "\n"))
    call nvim_buf_set_option(buf, 'ft', &ft)

    " Get the current UI
    let ui = nvim_list_uis()[0]

    " Create the floating window
    let opts = {'relative': 'win',
                \ 'width': width,
                \ 'height': height,
                \ 'col': (l:windowWidth/2) - (width/2),
                \ 'row': (l:windowHeight/2) - (height/2),
                \ 'anchor': 'NW',
                \ 'style': 'minimal',
                \ 'border': 'solid',
                \ }
    let win = nvim_open_win(buf, 1, opts)
endfunction
vnoremap <leader>se y :call EditVisualRegion(@")<CR>
" WIP SaveVisualRegionEdit END

function! SmartUnJoin()
    let match = searchpos("\[({ )}\]", "z", line("."))
    let col = l:match[1]
    if l:col != 0
        let char = getline(".")[l:col - 1]
        if char == " "
            normal xi
        elseif index(["(", "{"], char) != -1
            normal a
        else
            normal i
        endif
        normal w==
    endif
endfunction
nnoremap <leader>k :call SmartUnJoin()<CR>

" Global serach (files)
nnoremap <leader>p :call fzf#run(fzf#wrap({'source': 'rg --files --hidden --follow .'}))<CR>
nnoremap <leader>. :call fzf#run(fzf#wrap({'source': 'rg --files --hidden --follow .'}))<CR>
function! SearchFilesByWord(word)
    :execute ":FZF -q " . a:word
endfunction
vnoremap <leader>p :call SearchFilesByWord("<C-r><C-w>")<CR>
vnoremap <leader>. :call SearchFilesByWord("<C-r><C-w>")<CR>

"Substitue (rename anythign)
nnoremap <Leader>sa :%s//g<Left><Left>
" Rename word
nnoremap <Leader>sw :%s/\<<C-r><C-w>\>//gc<left><left><left>
" Rename tag
nnoremap <leader>st :call functions#ChangeTagName()<cr>
"Rename last search
nnoremap <leader>ss :%s///g<Left><Left>
vnoremap <leader>ss :s///g<Left><Left>
" Substitute visual block
nnoremap <Leader>sv :%s/\%V\%V//g<Left><Left><Left><Left><Left><Left>
vnoremap <Leader>sv :s/\%V\%V//g<Left><Left><Left><Left><Left><Left>

fun! CountMatches(range)
	let prev_view_user = winsaveview()
	let curr_search = @/
	let vrange = a:range !=# '%' ? '\%V' : ''
	" note that this doesn't work if the search was performed using a different separator than "/". that should be avoided though.
	exe a:range.'s/'.vrange.curr_search.'//n'
	call winrestview(prev_view_user)
endf
nnoremap <leader>n :<c-u>call CountMatches('%')<cr>
vnoremap <leader>n :<c-u>call CountMatches("'<,'>")<cr>
command! CountMatches :call CountMatches('%')<cr>

" Append character to the end of the line
nnoremap <silent><leader>a :call functions#AppendCharacterToEndOfLine()<cr>

" Quickly make the current file
nnoremap <Leader>m :silent make %<CR>

" Do not lose selection when indenting with '<' or '>' (visual mode)
xnoremap <  <gv
xnoremap >  >gv

" Readline mode mappings (insert and command mode)
" Jump to beginning of line
inoremap <C-A> <C-O>^
cnoremap <C-A> <Home>
" Make sure the original behaviour for <C-A> is still available
cnoremap <C-X><C-A> <C-A>
" Jump to end of line
inoremap <C-E> <C-O>$
cnoremap <C-E> <End>
" Kill rest of the line
inoremap <C-K> <C-O>d$
" cnorem
" Move one word backward, forward
inoremap <M-b> <C-Left>
cnoremap <M-b> <C-Left>
inoremap <M-f> <C-Right>
cnoremap <M-f> <C-Right>
" Move one character backward, forward
inoremap <C-b> <Left>
cnoremap <C-b> <Left>
inoremap <C-f> <Right>
cnoremap <C-f> <Right>

let g:UltiSnips#ExpandSnippet="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

vnoremap <leader>a :EasyAlign<CR>
nnoremap <leader>! :!

let g:hunk_actions = {
            \'s': {'title': "stage", 'execute': 'GitGutterStageHunk' },
            \'u': {'title': "undo", 'execute': 'GitGutterUndoHunk' }
            \}
let g:git_actions = {
            \'d': {'title': "diff", 'execute': 'Gdiff' },
            \'b': {'title': "blame", 'execute': 'Gblame' },
            \'m': {'title': "magit", 'execute': 'Git' },
            \'s': {'title': "Status", 'execute': 'Git' },
            \'h': {'title': "hunk", 'menu': g:hunk_actions },
            \'r': {'title': "remote", 'menu': { 'p': {'title': "push", 'execute': '!git push' }, 'P': {'title': "publish", 'execute': '!git publish' }, } },
            \}

nnoremap <silent> <leader>v  :call yamenu#Show(g:git_actions)<CR>

let g:open_actions = {
            \'v': {'title': "Open vimrc", 'execute': ':Vimrc' },
            \'w': {'title': "Websearch: ", 'execute': "Web" },
            \}
nnoremap <silent> <leader>o  :call yamenu#Show(g:open_actions)<CR>

" Open man pages, documentation or web search
fun! GetTypeHoverAction(word)
    try
        if (&filetype == 'vim')
            execute "h " . a:word
        " elseif has_key(g:LanguageClient_serverCommands, &filetype)
        "     silent call LanguageClient#textDocument_hover()
        else
            silent execute "Man " . a:word
        endif
    catch
        call websearch#Search(a:word)
    endtry
endfunction
nnoremap <silent> K :call GetTypeHoverAction("<C-R><C-W>")<CR>

" let g:send_disable_mapping = 1
nmap <leader>rss <Plug>SendLine
nmap <leader>rs <Plug>Send
vmap <leader>rs <Plug>Send
nmap <leader>rS s$

fun! Run()
    new | e term://
    :startinsert
endfunction

" }}}
"============================================================================
"Keybindings, custom mappings END
"============================================================================


"============================================================================
" Autcommands START
"============================================================================
" {{{
"
augroup BgHighlight
  autocmd!
  " autocmd WinEnter * set cul
  " autocmd WinLeave * set nocul
augroup END

augroup focusevents
    au!
    " Reload file if file changed
    au FocusGained,BufEnter * :silent! !
augroup end
"
" Open quickfix immediately after [l]grep has succeeded
augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost grep cwindow
    autocmd QuickFixCmdPost lgrep lwindow
augroup END

" Use spellcheck for certain filestypes
augroup spellcheck
    au!
    au Filetype markdown,asciidoc,text,gitcommit setlocal spell
augroup END

" Git commits
augroup gitcommits
    au!
    au Filetype gitcommit start
augroup END

augroup snippetsft
    au!
    autocmd BufEnter .snippets setlocal ft=make
augroup END

augroup yanking
    au TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}
augroup END

augroup noteshook
    autocmd!
    " Create commit message with the following format: "Updated <filename>"
    autocmd BufWritePost **/Documents/notes/* silent !file-commit.sh $HOME/Documents/notes "Update %:t"
augroup END

augroup journalhook
    autocmd!
    " There is no finnish spell file!
    autocmd BufEnter **/journal/* setlocal nospell
    " Add current date and time to the start of the document
    autocmd BufNewFile **/journal/* exe "-1 read !iso-date" | exe "normal I= \<esc>o\<cr>" | exe "-1 read !iso-time" | exe "normal IKello \<esc>2j" | startinsert
    " Create commit message with the following format: "Updated <filename>"
    autocmd BufWritePost **/journal/* silent !file-commit.sh $HOME/Dropbox/personal/journal "Update %:t"
augroup END

" disable US TrackChange python calls. they are costly (add delay when typing, an order of magnitude more than anything else) and don't seem essential
fun! ClearUsAu()
	augroup UltiSnips_AutoTrigger
		au!
	augroup END
endf
au VimEnter * call ClearUsAu()
" }}}
"============================================================================
" Autcommands END
"============================================================================


"============================================================================
" Additional plugin settings START
"============================================================================
" {{{
" 

"Default : 1
"
"When you press the key for the closing pair (e.g. `)`) it jumps past it.
"If set to 1, then it'll jump to the next line, if there is only whitespace.
"If set to 0, then it'll only jump to a closing pair on the same line.
let g:AutoPairsMultilineClose = 0
"
" ======== Git =========
" Gitgutter
let g:gitgutter_terminal_reports_focus=0

" Comment arrow functions also
let g:jsdoc_enable_es6 = 1
" ======== Tags =========
" ** Closetag **
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.jsx,*.js,*.blade.php,*.vue,*.liquid,*.html.leex"
" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

let delimitMate_matchpairs = "(:),[:],{:}"
" ======== Snippets =========
" ** UltiSnips **
let g:UltiSnipsSnippetsDir="~/.dotfiles/vim/custom-snippets"
let g:UltiSnipsSnippetDirectories=['custom-snippets']

" Use 'completefunc' to complete snippets for specific filetype
fun! CompleteSnippet(findstart, base)
    if a:findstart
        " locate the start of the word
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '\a'
            let start -= 1
        endwhile
        return start
    else
        let haystack = UltiSnips#SnippetsInCurrentScope(1)
        let res = []
        for m in keys(haystack)
            echo m
            if m =~ '^' . a:base
                call add(res, m)
            endif
        endfor
        return res
    endif
endfun
set completefunc=CompleteSnippet

command! -range GB echo join(systemlist("git blame -L <line1>,<line2> " . expand('%')), "\n")

let g:magit_default_fold_level = 0

" https://github.com/gruvbox-community/gruvbox/issues/126
let g:gruvbox_invert_selection = 0
if (&background == 'dark')
  hi Visual cterm=NONE ctermfg=NONE ctermbg=237 guibg=#3a3a3a
else
  hi Visual cterm=NONE ctermfg=NONE ctermbg=223 guibg=#ffd7af
endif
" }}}
"============================================================================
" Additional plugin settings END
"============================================================================

"============================================================================
" LSP START
"============================================================================
"{{{

lua << EOF
local nvim_lsp = require('lspconfig')
local aerial = require('aerial')
local null_ls = require('null-ls')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- attach aerial
  aerial.on_attach(client)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<F3>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<F5>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  --buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('v', '<leader>lf', ':lua vim.lsp.buf.range_formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- tsserver https://github.com/typescript-language-server/typescript-language-server
-- Python: https://github.com/python-lsp/python-lsp-server
-- php (intelephense): https://intelephense.com/
local servers = { 'pylsp', 'tsserver','vuels' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
  }
end

-- elixr-ls: https://github.com/elixir-lsp/elixir-ls
nvim_lsp.elixirls.setup{
  on_attach = on_attach,
  -- cmd = { '/Users/rikulaa/.local/bin/elixir-ls/language_server.sh' },
  cmd = { 'elixir-ls' },
  flags = {
    debounce_text_changes = 150,
  },
}

-- Setup php for wordpress also
-- https://github.com/Mte90/dotfiles/blob/master/.config/nvim/lua/plugin/lsp.lua
-- INSTALL THESE AS WELL composer global require php-stubs/wordpress-globals php-stubs/wordpress-stubs php-stubs/woocommerce-stubs php-stubs/acf-pro-stubs wpsyntex/polylang-stubs php-stubs/genesis-stubs php-stubs/wp-cli-stubs
nvim_lsp.intelephense.setup({
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
    settings = {
        intelephense = {
            stubs = { 
                "bcmath",
                "bz2",
                "calendar",
                "Core",
                "curl",
                "date",
                "dba",
                "dom",
                "enchant",
                "fileinfo",
                "filter",
                "ftp",
                "gd",
                "gettext",
                "hash",
                "iconv",
                "imap",
                "intl",
                "json",
                "ldap",
                "libxml",
                "mbstring",
                "mcrypt",
                "mysql",
                "mysqli",
                "password",
                "pcntl",
                "pcre",
                "PDO",
                "pdo_mysql",
                "Phar",
                "readline",
                "recode",
                "Reflection",
                "regex",
                "session",
                "SimpleXML",
                "soap",
                "sockets",
                "sodium",
                "SPL",
                "standard",
                "superglobals",
                "sysvsem",
                "sysvshm",
                "tokenizer",
                "xml",
                "xdebug",
                "xmlreader",
                "xmlwriter",
                "yaml",
                "zip",
                "zlib",
                "wordpress",
                "woocommerce",
                "acf-pro",
                "wordpress-globals",
                "wp-cli",
                "genesis",
                "polylang"
            },
            files = {
                maxSize = 5000000;
            };
        };
    },
    capabilities = capabilities,
});

local severities = {
  error = vim.lsp.protocol.DiagnosticSeverity.Error,
  warning = vim.lsp.protocol.DiagnosticSeverity.Warning,
  refactor = vim.lsp.protocol.DiagnosticSeverity.Information,
  convention = vim.lsp.protocol.DiagnosticSeverity.Hint,
}

-- Setup null-ls
null_ls.setup({
     -- you must define at least one source for the plugin to work
    sources = {
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.formatting.mix,
        null_ls.builtins.diagnostics.pylint
    },
    on_attach = on_attach
})

--require'nvim-treesitter.configs'.setup {
  --ensure_installed = { 'javascript' }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ---- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  --highlight = {
    --enable = true,              -- false will disable the whole extension
    ---- disable = { "c", "rust" },  -- list of language that will be disabled
    ---- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    ---- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    ---- Using this option may slow down your editor, and you may see some duplicate highlights.
    ---- Instead of true it can also be a list of languages
    --additional_vim_regex_highlighting = false,
  --},
--}

EOF

"============================================================================
" LSP END
"============================================================================


" }}}
"
"
" TODO: Convert to init.lua ?
" TODO: Lua snip plugin?
" TODO: telescope?

""
"===========
" Local 
"==========
let f = getcwd()."/init.vim"
if filereadable(f)
    let trusted_file_path = stdpath("cache") . "/" . "trusted_init_files"
    let is_allowed_to_source = 0
    try
        let trusted_files = readfile(trusted_file_path)
        let idx = index(trusted_files, f)
        let is_allowed_to_source = idx != 1 ? 1 : 0
    catch
    endtry

    if (!is_allowed_to_source)
        let can_source = input("Local init.vim found, allow to read from it, y(es), n(o) ? ")
    endif

    if (is_allowed_to_source || match("yes", can_source) == 0)
        " Save the choice
        if (!is_allowed_to_source)
            call writefile([f], trusted_file_path, "a")
        endif
        execute "source " f
    endif
endif

" inoremap ( ()<left>
" inoremap (<Space> (<Space><Space>)<Left><Left>
inoremap (<CR> (<CR>)<ESC>O<ESC>cc
" inoremap [ []<left>
" inoremap [<Space> [<Space><Space>]<Left><Left>
inoremap [<CR> [<CR>]<ESC>O<ESC>cc
" inoremap { {}<left>
" inoremap {<Space> {<Space><Space>}<Left><Left>
inoremap {<CR> {<CR>}<ESC>O<ESC>cc

" function IsBetweenBraces()
"     return strpart(getline('.'), col('.')-1, 1) == ")" ? "\<cr>\<esc>\O" : "\<cr>"
" endfunction
" inoremap <expr> <cr> IsBetweenBraces()

" inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
" inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
" inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
" inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
" inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"
" inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"
"

" iabbrev :eyes: 👀
" iabbrev :raised_hands: 🙌
" iabbrev :pray: 🙏
" iabbrev :heavy_plus_sign: ➕
" iabbrev :clap: 👏
" iabbrev :bulb: 💡
" iabbrev :dart: 🎯
" iabbrev :wave: 👋
" iabbrev :thumbsup: 👍
" iabbrev :tada: 🎉
" iabbrev :mega: 📣
" iabbrev :white_circle: ⚪
" iabbrev :large_blue_circle: 🔵
" iabbrev :red_circle: 🔴
" iabbrev :joy: 😁
" iabbrev :rolling_on_the_floor_laughing: 🤣
" iabbrev :smiley: 😃
" iabbrev :smile: 😊
" iabbrev :sweat_smile: 😅
" iabbrev :wink: 😉
" iabbrev :blush: 😳
" iabbrev :yum: 😋
" iabbrev :sunglasses: 😎
" iabbrev :heart_eyes: 😍
" iabbrev :kissing_heart: 😘
" iabbrev :kissing: 😗
" iabbrev :kissing_smiling_eyes: 😙
" iabbrev :kissing_closed_eyes: 😚
" iabbrev :relaxed: 😌
" iabbrev :slightly_smiling_face: 🙂
" iabbrev :hugging_face: 🤗
" iabbrev :star-struck: 🤩
" iabbrev :thinking_face: 🤔
" iabbrev :face_with_raised_eyebrow: 🤨
" iabbrev :neutral_face: 😐
" iabbrev :expressionless: 😑
" iabbrev :no_mouth: 😶
" iabbrev :face_with_rolling_eyes: 🙄
" iabbrev :smirk: 😏
" iabbrev :persevere: 😣
" iabbrev :disappointed_relieved: 😥
" iabbrev :open_mouth: 😮
" iabbrev :zipper_mouth_face: 🤐
" iabbrev :hushed: 😯
" iabbrev :sleepy: 😴
" iabbrev :tired_face: 😫
" iabbrev :sleeping: 😴
" iabbrev :relieved: 😌
" iabbrev :stuck_out_tongue: 😛
" iabbrev :stuck_out_tongue_winking_eye: 😜
" iabbrev :stuck_out_tongue_closed_eyes: 😝
" iabbrev :drooling_face: 🤤
" iabbrev :unamused: 😒
" iabbrev :sweat: 😓
" iabbrev :pensive: 😔
" iabbrev :confused: 😕
" iabbrev :upside_down_face: 🙃
" iabbrev :money_mouth_face: 🤑
" iabbrev :astonished: 😲
" iabbrev :white_frowning_face: ☹️
" iabbrev :slightly_frowning_face: 🙁
" iabbrev :confounded: 😖
" iabbrev :disappointed: 😞
" iabbrev :worried: 😟
" iabbrev :triumph: 😤
" iabbrev :cry: 😢
" iabbrev :sob: 😭
" iabbrev :frowning: 😦
" iabbrev :anguished: 😧
" iabbrev :fearful: 😨
" iabbrev :weary: 😩
" iabbrev :exploding_head: 🤯
" iabbrev :grimacing: 😬
" iabbrev :cold_sweat: 😰
" iabbrev :scream: 😱
" iabbrev :flushed: 😳
" iabbrev :zany_face: 🤪
" iabbrev :dizzy_face: 😵
" iabbrev :rage: 😡
" iabbrev :angry: 😠
" iabbrev :face_with_symbols_on_mouth: 🤬
" iabbrev :mask: 😷
" iabbrev :face_with_thermometer: 🤒
" iabbrev :face_with_head_bandage: 🤕
" iabbrev :nauseated_face: 🤢
" iabbrev :face_vomiting: 🤮
" iabbrev :sneezing_face: 🤧
" iabbrev :innocent: 😇
" iabbrev :face_with_cowboy_hat: 🤠
" iabbrev :clown_face: 🤡
" iabbrev :lying_face: 🤥
" iabbrev :shushing_face: 🤫
" iabbrev :face_with_hand_over_mouth: 🤭
" iabbrev :face_with_monocle: 🧐
" iabbrev :nerd_face: 🤓
" iabbrev :smiling_imp: 😈
" iabbrev :imp: 👿
" iabbrev :japanese_ogre: 👹
" iabbrev :japanese_goblin: 👺
" iabbrev :skull: 💀
" iabbrev :skull_and_crossbones: ☠️
" iabbrev :ghost:
" iabbrev :alien: 👻
" iabbrev :space_invader: 👾
" iabbrev :robot_face: 🤖
" iabbrev :hankey: 💩
" iabbrev :smiley_cat: 😺
" iabbrev :smile_cat: 😸
" iabbrev :joy_cat: 😹
" iabbrev :heart_eyes_cat: 😻
" iabbrev :smirk_cat: 😼
" iabbrev :kissing_cat: 😽
" iabbrev :scream_cat: 🙀
" iabbrev :crying_cat_face: 😿
" iabbrev :pouting_cat: 😾
" iabbrev :see_no_evil: 🙈
" iabbrev :hear_no_evil: 🙉
" iabbrev :speak_no_evil: 🙊
" iabbrev :baby: 👶
" iabbrev :child: 🧒
" iabbrev :boy: 👦
" iabbrev :girl: 👧
" iabbrev :adult: 🧑
" iabbrev :man: 👨
" iabbrev :woman: 👩
" iabbrev :older_adult: 🧓
" iabbrev :older_man: 👴
" iabbrev :older_woman: 👵
" iabbrev :female-doctor: 👩‍⚕️
" iabbrev :male-student: 👨‍🎓
" iabbrev :female-student: 👩‍🎓
" iabbrev :male-teacher: 👨‍🏫
" iabbrev :male-teacher: 👩‍🏫
" iabbrev :male-judge: 👨‍⚖️
" iabbrev :female-judge: 👩‍⚖️
" iabbrev :male-farmer: 👨‍🌾
" iabbrev :female-farmer: 👩‍🌾
" iabbrev :male-cook: 👨‍🍳
" iabbrev :female-cook: 👩‍🍳
" iabbrev :male-mechanic: 👨‍🔧
" iabbrev :female-mechanic: 👩‍🔧
" iabbrev :male-factory-worker: 👨‍🏭
" iabbrev :female-factory-worker: 👩‍🏭
" iabbrev :male-office-worker: 👨🏻‍💼
" iabbrev :female-office-worker: 👩🏻‍💼
" iabbrev :male-scientist: 👨‍🔬
" iabbrev :female-scientist: 👩‍🔬
" iabbrev :male-technologist: 👨‍💻
" iabbrev :female-technologist: 👩‍💻
" iabbrev :male-singer: 👨‍🎤
" iabbrev :female-singer: 👩‍🎤
" iabbrev :male-artist: 👨‍🎨
" iabbrev :female-artist: 👩‍🎨
" iabbrev :male-pilot: 👨‍✈️
" iabbrev :female-pilot: 👩‍✈️
" iabbrev :male-astronaut: 👨‍🚀
" iabbrev :female-astronaut: 👩‍🚀
" iabbrev :male-firefighter: 👨‍🚒
" iabbrev :female-firefighter: 👩‍🚒
" iabbrev :male-police-officer: 👮‍♂️
" iabbrev :female-police-officer: 👮‍♀️
" iabbrev :male-detective: 🕵️‍♂️
" iabbrev :female-detective: 🕵️‍♀️
" iabbrev :male-guard: 💂‍♂️
" iabbrev :female-guard: 💂‍♀️
" iabbrev :male-construction-worker: 👷‍♂️
" iabbrev :female-construction-worker: 👷‍♀️
" iabbrev :prince: 🤴
" iabbrev :princess: 👸
" iabbrev :man-wearing-turban: 👳‍♂️
" iabbrev :woman-wearing-turban: 👳‍♀️
" iabbrev :man_with_gua_pi_mao: 👲
" iabbrev :person_with_headscarf: 🧕
" iabbrev :bearded_person: 🧔
" iabbrev :blond-haired-man: 👱‍♂️
" iabbrev :blond-haired-woman: 👱‍♀️
" iabbrev :man_in_tuxedo: 🤵‍♂️
" iabbrev :bride_with_veil: 👰
" iabbrev :pregnant_woman: 🤰
" iabbrev :breast-feeding: 🤱
" iabbrev :angel: 👼
" iabbrev :santa: 🎅
" iabbrev :mrs_claus: 🤶
" iabbrev :female_mage: 🧙‍♀️
" iabbrev :male_mage: 🧙‍♂️
" iabbrev :female_fairy: 🧚‍♀️
" iabbrev :male_fairy: 🧚‍♂️
" iabbrev :female_vampire: 🧛‍♀️
" iabbrev :male_vampire: 🧛‍♂️
" iabbrev :mermaid: 🧜‍♀️
" iabbrev :merman: 🧜‍♂️
" iabbrev :female_elf: 🧝‍♀️
" iabbrev :male_elf: 🧝‍♂️
" iabbrev :female_genie: 🧞‍♀️
" iabbrev :male_genie: 🧞‍♂️
" iabbrev :female_zombie: 🧟‍♀️
" iabbrev :male_zombie: 🧟‍♂️
" iabbrev :man-frowning: 🙍‍♂️
" iabbrev :woman-frowning: 🙍‍♀️
" iabbrev :man-pouting: 🙎‍♂️
" iabbrev :woman-pouting: 🙎‍♀️
" iabbrev :man-gesturing-no: 🙅‍♂️
" iabbrev :woman-gesturing-no: 🙅‍♀️
" iabbrev :man-gesturing-ok: 🙆‍♂️
" iabbrev :woman-gesturing-ok: 🙆‍♀️
" iabbrev :man-tipping-hand: 💁‍♂️
" iabbrev :woman-tipping-hand: 💁‍♀️
" iabbrev :man-raising-hand: 🙋‍♂️
" iabbrev :woman-raising-hand: 🙋‍♀️
" iabbrev :man-bowing: 🙇‍♂️
" iabbrev :woman-bowing: 🙇‍♀️
" iabbrev :man-facepalming: 🤦‍♂️
" iabbrev :woman-facepalming: 🤦‍♀️
" iabbrev :man-shrugging: 🤷‍♂️
" iabbrev :woman-shrugging: 🤷‍♀️
" iabbrev :man-getting-massage: 💆‍♂️
" iabbrev :woman-getting-massage: 💆‍♀️
" iabbrev :man-getting-haircut: 💇‍♂️
" iabbrev :woman-getting-haircut: 💇‍♀️
" iabbrev :man-walking: 🚶‍♂️
" iabbrev :woman-walking: 🚶‍♀️
" iabbrev :man-running: 🏃‍♂️
" iabbrev :woman-running: 🏃‍♀️
" iabbrev :dancer: 💃
" iabbrev :man_dancing: 🕺
" iabbrev :man-with-bunny-ears-partying: 👯‍♂️
" iabbrev :woman-with-bunny-ears-partying: 👯‍♀️
" iabbrev :woman_in_steamy_room: 🧖‍♀️
" iabbrev :man_in_steamy_room: 🧖‍♂️
" iabbrev :woman_climbing: 🧗‍♀️
" iabbrev :man_climbing: 🧗‍♂️
" iabbrev :woman_in_lotus_position: 🧘‍♀️
" iabbrev :man_in_lotus_position: 🧘‍♂️
" iabbrev :bath: 🛀
" iabbrev :sleeping_accommodation: 🛌
" iabbrev :sunny: ☀️
" iabbrev :umbrella: ☂️
" iabbrev :cloud: ☁️
" iabbrev :snowflake: ❄️
" iabbrev :snowman: ☃️
" iabbrev :zap: ⚡
" iabbrev :cyclone: 🌀
" iabbrev :foggy: 🌁
" iabbrev :ocean: 🌊
" iabbrev :cat: 🐈
" iabbrev :dog: 🐕
" iabbrev :mouse: 🐁
" iabbrev :hamster: 🐹
" iabbrev :rabbit: 🐇
" iabbrev :wolf: 🐺
" iabbrev :frog: 🐸
" iabbrev :tiger: 🐅
" iabbrev :koala: 🐨
" iabbrev :bear: 🐻
" iabbrev :pig: 🐖
" iabbrev :pig_nose: 🐽
" iabbrev :cow: 🐄
" iabbrev :boar: 🐗
" iabbrev :monkey_face: 🐵
" iabbrev :monkey: 🐒
" iabbrev :horse: 🐎
" iabbrev :racehorse: 🏇
" iabbrev :camel: 🐪
" iabbrev :sheep: 🐑
" iabbrev :elephant: 🐘
" iabbrev :panda_face: 🐼
" iabbrev :snake: 🐍
" iabbrev :bird: 🐦
" iabbrev :baby_chick: 🐤
" iabbrev :hatched_chick: 🐣
" iabbrev :chicken: 🐔
" iabbrev :penguin: 🐧
" iabbrev :turtle: 🐢
" iabbrev :bug: 🐛
" iabbrev :honeybee: 🐝
" iabbrev :ant: 🐜
" iabbrev :beetle: 🐞
" iabbrev :snail: 🐌
" iabbrev :octopus: 🐙
" iabbrev :tropical_fish: 🐠
" iabbrev :fish: 🐟
" iabbrev :whale: 🐋
" iabbrev :dolphin: 🐬
" iabbrev :gift_heart: 💝
" iabbrev :dolls: 🎎
" iabbrev :school_satchel: 🎒
" iabbrev :mortar_board: 🎓
" iabbrev :flags: ⛳
" iabbrev :fireworks: 🎆
" iabbrev :sparkler: ✨
" iabbrev :wind_chime: 🎐
" iabbrev :jack_o_lantern: 🎃
" iabbrev :ghost: 👻
" iabbrev :santa: 🎅
" iabbrev :christmas_tree: 🎄
" iabbrev :gift: 🎁
" iabbrev :bell: 🔔
" iabbrev :no_bell: 🔕
" iabbrev :tanabata_tree: 🎋
" iabbrev :tada: 🎉
" iabbrev :confetti_ball: 🎊
" iabbrev :balloon: 🎈
" iabbrev :crystal_ball: 🔮
" iabbrev :cd: 💿
" iabbrev :dvd: 📀
" iabbrev :floppy_disk: 💾
" iabbrev :camera: 📷
" iabbrev :video_camera: 📹
" iabbrev :movie_camera: 🎥
" iabbrev :computer: 🖥️
" iabbrev :tv: 📺
" iabbrev :phone: 📱
" iabbrev :telephone: ☎️
" iabbrev :telephone_receiver: 📞
" iabbrev :pager: 📟
" iabbrev :fax: 📠
" iabbrev :minidisc: 💽
" iabbrev :vhs: 📼
" iabbrev :house: 🏠
" iabbrev :house_with_garden: 🏡
" iabbrev :school: 🏫
" iabbrev :office: 🏢
" iabbrev :post_office: 🏤
" iabbrev :hospital: 🏥
" iabbrev :bank: 🏦
" iabbrev :convenience_store: 🏪
" iabbrev :hotel: 🏨
" iabbrev :wedding: 💒
" iabbrev :church: ⛪
" iabbrev :department_store: 🏬
" iabbrev :tent: ⛺
" iabbrev :factory: 🏭
" iabbrev :tokyo_tower: 🗼
" iabbrev :japan: 🗾
" iabbrev :mount_fuji: 🗻
" iabbrev :sunrise_over_mountains: 🌄
" iabbrev :sunrise: 🌅
" iabbrev :statue_of_liberty: 🗽
" iabbrev :bridge_at_night: 🌉
" iabbrev :carousel_horse: 🎠
" iabbrev :rainbow: 🌈
" iabbrev :ferris_wheel: 🎡
" iabbrev :fountain: ⛲
" iabbrev :roller_coaster: 🎢
" iabbrev :ship: 🚢
" iabbrev :speedboat: 🚤
" iabbrev :boat: 🛥️
" iabbrev :sailboat: ⛵
