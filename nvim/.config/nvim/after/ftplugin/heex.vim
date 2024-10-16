" Todo should this be runned by conform
set formatprg=mix\ format

augroup formathook
    autocmd!
    " Format the buffer
    autocmd BufWritePost *.heex silent !mix format %
augroup END
