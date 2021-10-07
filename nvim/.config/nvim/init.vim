"============================================================================
" Plugs
"============================================================================
" {{{
call plug#begin('$HOME/.config/nvim/bundle')

" General usability
Plug 'tpope/vim-commentary'           " Comments
Plug 'tpope/vim-surround'             " Vim Surround plugin
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-abolish'            " For converting name cases

Plug 'neovim/nvim-lspconfig'

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
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
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

" Linting
if (has('nvim') || v:version > 800)
    Plug 'w0rp/ale'
endif

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
set timeoutlen=3000
set ttimeout
set ttimeoutlen=50
set lazyredraw              " E.g do not draw screen between macros, makes them run faster
set spelllang=en

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
syntax enable				" Show syntax
set termguicolors           " Better colors in terminal, needs support from tmux also

colorscheme gruvbox
let iterm_profile = $ITERM_PROFILE
if iterm_profile == "Light"
    set background=light        " Set light background explicitely
else
    set background=dark
endif
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
if executable('rg')
    set grepprg=rg\ --vimgrep    " Use ripgrep instad of grep"
endif
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
command! Eft :execute 'e ~/.config/nvim/after/ftplugin/'.&filetype.'.vim'
command! Esy :execute 'e ~/.config/nvim/after/syntax/'.&filetype.'.vim'
command! Reload :source $MYVIMRC

command! -nargs=? Web :call websearch#Search(<q-args>)

command! So :source %

command! Bdall silent! :%bdelete
command! Rm :call functions#DeleteAndCloseBuffer()
command! -nargs=1 -complete=file Mv silent :call functions#MoveBuffer(<q-args>)
command! -nargs=1 -complete=file Cp silent :call functions#CopyBuffer(<q-args>)

" Format json by piping it into jq
command! -range FormatJson silent :'<,'>!jq


" Git: stage current file
command! Ga :!git a %

command! Foldopen normal zR
command! Foldclose normal zM

" Better grep (https://noahfrederick.com/log/vim-streamlining-grep
" - Don't show confirmation after search by using silent
" - Open quickfix window immediately
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep' : 'lgrep'

" Command for resyncing screen
command! ResyncScreen :syntax sync fromstart<cr>:redraw!<cr>

" Command for quickly checking up cheatsheets
command! -nargs=1 -bang -complete=customlist,EditCheatsheetComplete
            \ Cheat 15split<bang> <args>
function! EditCheatsheetComplete(A,L,P)
    return split(globpath('~/.dotfiles/cheatsheets/', a:A.'*'), "\n")
endfun
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

" Navigation (between quickfix items)
nnoremap ]q :cnext<CR>
nnoremap [q :cprev<CR>
" Navigation (between arglist items)
nnoremap ]a :next<CR>
nnoremap [a :prev<CR>

" Navigate between errors
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)

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
nnoremap <leader>/ :silent grep 
" Search the visual selection (as string literal)
function! StringLiteralSearch(str)
    let _str = escape(fnameescape(substitute(a:str, '\n', '', '')), '|()')
    execute ":silent grep -F " . _str
endfunction
vnoremap <leader>/ y :call StringLiteralSearch(@")

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

" Append character to the end of the line
nnoremap <silent><leader>a :call functions#AppendCharacterToEndOfLine()<cr>

" This needs to configured for each language OR reduce the timeout
" nnoremap <Leader>lf :ALEFix<CR>

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
            \'m': {'title': "magit", 'execute': 'Magit' },
            \'s': {'title': "Status", 'execute': '!git status' },
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

" }}}

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

augroup snippetsft
    au!
    autocmd BufEnter .snippets setlocal ft=make
augroup END

augroup noteshook
    autocmd!
    " Create commit message with the following format: "Updated <filename>"
    autocmd BufWritePost **/Documents/notes/* silent !notes-commit.sh "Update %:t"
augroup END

augroup journalhook
    autocmd!
    " There is no finnish spell file!
    autocmd BufEnter **/Documents/journal/* setlocal nospell
    " Add current date and time to the start of the document
    autocmd BufNewFile **/Documents/journal/* exe "-1 read !iso-date" | exe "normal I= \<esc>o\<cr>" | exe "-1 read !iso-time" | exe "normal IKello \<esc>2j" | startinsert
augroup END
" cmap <c-c> <c-c><c-c>
"============================================================================
" Additional plugin settings
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

" ======== Linting =========
let g:ale_fixers = {
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \'javascript': ['eslint', 'prettier'],
            \'c': ['clang-format'],
            \ 'php': ['phpcbf', 'php_cs_fixer'],
            \ 'python': ['pylint'],
            \}
let g:ale_linters = {
            \'javascript': ['eslint'],
            \ 'php': ['php', 'phpcs', 'phpmd', 'phpstan', 'langserver'],
            \ 'python': ['pylint'],
            \}

" Dont use autoompletion from ale
let g:ale_completion_enabled = 0

" " Dont show error highlights on lines, causes vim to slow down on huge files
" let g:ale_set_highlights = 0

let g:ale_php_phpstan_executable=$PWD.'/vendor/bin/phpstan'
let g:ale_php_phpstan_level = 7
let g:ale_php_langserver_executable=$HOME.'/.dotfiles/vim/plugin/php-language-server/vendor/bin/php-language-server.php'

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
" LSP
"============================================================================
"{{{

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
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
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  --buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- tsserver https://github.com/typescript-language-server/typescript-language-server
-- Python: https://github.com/python-lsp/python-lsp-server
-- php (intelephense): https://intelephense.com/
local servers = { 'pylsp', 'tsserver', 'intelephense', 'vuels' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    handlers = {
      ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
          -- Disable virtual_text
          virtual_text = false
        }
      ),
    }
  }
  -- elixr-ls: https://github.com/elixir-lsp/elixir-ls
  nvim_lsp.elixirls.setup{
      on_attach = on_attach,
      cmd = { '/Users/rikulaa/.local/bin/elixir-ls/language_server.sh' },
      flags = {
        debounce_text_changes = 150,
      },
      handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(
          vim.lsp.diagnostic.on_publish_diagnostics, {
            -- Disable virtual_text
            virtual_text = false
          }
        ),
      }
  }
end
EOF
" }}}
"
"
" TODO: Convert to init.lua ?
" TODO: Lua snip plugin?
" TODO: telescope?

