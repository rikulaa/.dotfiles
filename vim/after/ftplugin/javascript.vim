" Only do this when not done yet for this buffer
if exists("b:javascript_ftplugin")
    finish
endif

augroup jssetup
    au!
    au FileType javascript compiler eslint
    au FileType javascript setlocal formatprg=prettier.sh\ --stdin\ --parser\ typescript
augroup end

set define=^\s*\\(const\\|\s*let\\)

set tabstop=2
set softtabstop=2
set shiftwidth=2			" When indenting with >
set expandtab				" When tabbing, insert (four) spaces

let b:javascript_ftplugin = 1

