set formatprg=mix\ format

augroup formathook
    autocmd!
    " Format the buffer
    autocmd BufWritePost *.ex silent !mix format %
augroup END

nnoremap <silent> <leader>ll :call WrapText("<C-R><C-L>", "IO.inspect([&])")<CR>
vnoremap <leader>ll y :call WrapText(@", "IO.inspect([&])")<CR>
