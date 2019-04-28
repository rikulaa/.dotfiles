" Only do this when not done yet for this buffer
if exists("b:javascript_ftplugin")
    finish
endif

augroup jssetup
    au!
    au FileType javascript compiler eslint
    au FileType javascript setlocal formatprg=prettier.sh\ --stdin\ --parser\ typescript
augroup end

" Add node_modules to path
setlocal path+=node_modules
setlocal define=^\s*\\(const\\\|let\\\|var\\)
 
setlocal suffixesadd=.js,.json,.jsx

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2			" When indenting with >
setlocal expandtab				" When tabbing, insert (four) spaces

let b:javascript_ftplugin = 1

