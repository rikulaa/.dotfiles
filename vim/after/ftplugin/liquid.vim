setlocal suffixesadd=.liquid

function! ValidateLiquidSchema()
    /{%\s\?schema\s\?%}
    silent normal j"zya{
    " Create 'scratch' window
    e tmp.json 
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    normal "zp
endfunction

let __IncludeActions = {
            \'v': {'title': "Validate schema", 'execute': 'call ValidateLiquidSchema()' },
            \}

nnoremap <silent> <leader>L  :call yamenu#Show(__IncludeActions)<CR>

