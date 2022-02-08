autocmd FileType vue syntax sync fromstart
 
setlocal suffixesadd=.js,.json,.vue

nnoremap <silent> <leader>ll :call WrapText("<C-R><C-L>", "console.log(&)")<CR>
vnoremap <leader>ll y :call WrapText(@", "console.log(&)")<CR>
