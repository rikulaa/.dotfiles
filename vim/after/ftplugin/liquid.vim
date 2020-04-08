setlocal suffixesadd=.liquid

" Configure 'path' for Shopify projects
set path+=assets/**,config/**,layout/**,locales/**,scripts/**,sections/**,snippets/**,styles/**,templates/**,src/**

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

" To search pattern for split single lined 'render' or 'include' into multiline
" pattern explanation
" {%\       Match these characters
" \(-\)\?   Optionally match '-'
" \zs       Start capture  (forgets the previous characters) and match whitespace
" \|        add OR match
" ,         match , character
" \zs       Start capture (forgets the previous characters and match whitespace
" \|        Start capture group
" \s        Match whitespace
" \ze       End capture
" \(-\)\?   Optionally match '-'
" %}        match %}
"
" \r        replace with new line
" 
command! LiquidRenderTagToMultipleLine s/{%\(-\)\?\zs\|,\zs\|\s\ze\(-\)\?%}/\r/g | :noh
