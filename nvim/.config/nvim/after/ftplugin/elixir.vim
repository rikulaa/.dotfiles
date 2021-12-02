set formatprg=mix\ format

augroup formathook
    autocmd!
    " Format the buffer
    autocmd BufWritePost *.ex silent !mix format %
augroup END
