augroup jssetup
    au FileType javascript compiler eslint
augroup end

set define=^\s*\\(const\\|\s*let\\)

set tabstop=2
set softtabstop=2
set shiftwidth=2			" When indenting with >
set expandtab				" When tabbing, insert (four) spaces
