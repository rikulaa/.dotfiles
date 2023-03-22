setlocal formatprg=./vendor/bin/php-cs-fixer\ fix 

function! __PhpInsertUse()
    call PhpInsertUse()
    call PhpSortUse()
endfunction

" let __IncludeActions = {
"             \'a': {'title': "add import", 'execute': 'call __PhpInsertUse()' },
"             \'s': {'title': "sort imports", 'execute': 'call PhpSortUse()' },
"             \}

" nnoremap <silent> <leader>l  :call yamenu#Show(__IncludeActions)<CR>

" https://gist.github.com/romainl/f2d0727bdb9bde063531cd237f47775f
" Tell Vim to look for a specific tags file (standard library, reference implementation, etc.) in addition to the standard ones define above:
setlocal tags+=vendor/tags

function! JsonToAssocArray() range
    silent execute a:firstline.','.a:lastline.'s/{/[/g'
    silent execute a:firstline.','.a:lastline.'s/}/]/g'
    silent execute a:firstline.','.a:lastline.'s/:/ =>/g'
    normal gv=
endfunction

function! AssocArrayToJson() range
    silent execute a:firstline.','.a:lastline.'s/\[/{/g'
    silent execute a:firstline.','.a:lastline.'s/\]/}/g'
    silent execute a:firstline.','.a:lastline.'s/=>/:/g'
    normal gv=
endfunction

" command! -range PhpJsonToAssocativeArray :call PhpJsonToAssocativeArray()
" command! -range PhpJsonToAssocativeArray substitute(@*,"{","[","g")
command! -range JsonToAssocArray <line1>,<line2>call JsonToAssocArray()
command! -range AssocArrayToJson <line1>,<line2>call AssocArrayToJson()

set tabstop=4
set softtabstop=4
set shiftwidth=4			" When indenting with >

" autocmd FileType php setlocal omnifunc=phpactor#Complete
