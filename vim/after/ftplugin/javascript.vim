" Only do this when not done yet for this buffer
if exists("b:javascript_ftplugin")
    finish
endif

compiler jest
setlocal formatprg=prettier.sh\ --stdin\ --parser\ typescript

" Add node_modules to path
setlocal path+=node_modules
" Vim will treat these as macros
" setlocal define=^\s*\\(const\\\|let\\\|function\\\|class\\\|var\\)
setlocal define=\\(const\\\|let\\\|function\\\|class\\\|var\\)
" The 'import' statemets
" set include=from
setlocal include=^\\s*[^\/]\\+\\(from\\\|require(['\"]\\)
 
setlocal suffixesadd=.js,.json,.jsx

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2			" When indenting with >
setlocal expandtab				" When tabbing, insert (four) spaces

let b:javascript_ftplugin = 1

function! JsSortUse()
    %sort /\/[A-z]/ r
endfunction

let __IncludeActions = {
            \'s': {'title': "sort imports", '': function('JsSortUse', []) },
            \}

nnoremap <silent> <leader>L  :call prompter#Show(__IncludeActions)<CR>
