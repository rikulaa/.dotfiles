set makeprg=asciidoctor
setlocal commentstring=//\ %s

nnoremap <leader>td :call asciidoc#toggle_done()<CR>
" TOOD: <c-i> will break with these
" nnoremap <Tab> :call asciidoc#demote_item()<CR>
" nnoremap <S-Tab> :call asciidoc#promote_item()<CR>

