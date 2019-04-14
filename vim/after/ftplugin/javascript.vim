augroup jssetup
    au FileType javascript compiler eslint
augroup end

set define=^\s*\\(const\\|\s*let\\)
