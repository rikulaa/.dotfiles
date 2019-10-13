compiler jest
setlocal formatprg=prettier.sh\ --stdin\ --parser\ typescript

" Add node_modules to path
setlocal path+=node_modules
" Vim will treat these as macros
" setlocal define=^\s*\\(const\\\|let\\\|function\\\|class\\\|var\\)
setlocal define=\\(const\\\|let\\\|function\\\|class\\\|var\\)
" The 'import' statemets
" set include=from
setlocal include=^\\s*[^\/]\\+\\(from\\\|require(['\"]\\)
 
setlocal suffixesadd=.js,.json,.jsx

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2			" When indenting with >
setlocal expandtab				" When tabbing, insert (four) spaces

function! JsSortUse()
    %sort /\/[A-z]/ r
endfunction

let __IncludeActions = {
            \'s': {'title': "sort imports", '': function('JsSortUse', []) },
            \}

nnoremap <silent> <leader>L  :call yamenu#Show(__IncludeActions)<CR>

" Toggles between:
"
" import {a,b,c} from 'a' 
" import {
"   a,
"   b,
"   c
" } from 'a'
function! ToggleImportsOrientation()
    normal 0

    let l:isSingleLineImport = search('{.*}', '', line('.'))
   
    " All import on single line
    if isSingleLineImport
        execute "normal 0f{a\<CR>"

        let l:matches = searchpos(',', 'z', line("."))
        while l:matches[1] > 0
            execute "normal lxi\<CR>"
            let l:matches = searchpos(',', 'z', line("."))
        endwhile

        execute "normal f}i\<CR>"
    else
        " Imports on multiple lines
        let l:isMultiLineEnd = search('}', '', line('.'))
        let l:isMultiLineStart = search('{', '', line('.'))

        " Move to starting bracket
        if isMultiLineStart
            normal f{
        elseif isMultiLineEnd
            normal f}
        endif

        " Move everything to one line
        normal va{J

        " Trim whitespace before and after brackets
        *s/{\s/{/g
        *s/\s}/}/g

    endif
endfunction

" Toggles between
"
" function(a, b, c)
"
" function(
"   a,
"   b,
"   c,
" )
function! ToggleFuncParamOrientation()

    normal 0

    let l:isDefinedInSingle = search('(.*)', '', line('.'))


    " All params on single line
    if isDefinedInSingle
        execute "normal 0f(a\<CR>"

        let l:matches = searchpos(',', 'z', line("."))
        while l:matches[1] > 0
            execute "normal lxi\<CR>"
            let l:matches = searchpos(',', 'z', line("."))
        endwhile

        execute "normal f)i\<CR>"
    else
        " Imports on multiple lines
        let l:isMultiLineEnd = search(')', '', line('.'))
        let l:isMultiLineStart = search('(', '', line('.'))

        " Move to starting bracket
        if isMultiLineStart
            normal f(
        elseif isMultiLineEnd
            normal f)
        endif

        " Move everything to one line
        normal va(J

        " Trim whitespace before and after brackets

        *s/(\s/(/g
        " *s/\s)/)/g

    endif
endfunction


" Comment JSX
function! CommentJsx()
    normal `>o */}
    normal `<O{/*
    normal f}x
endfunction


" Change function syntax
function! ToggleJSFunctionSyntax()
    let currentLine=getline('.')

    " Check if this is older syntax
    if matchstr(currentLine, "function") == "function"

        " Check if assigned function
        if matchstr(currentLine, "=") == "="
            " Check if var is used, and change it to const
            if matchstr(currentLine, 'var') == "var"
                normal 0ceconst
            endif
            " Change to arrow syntax
            normal 0f=wdt(f)la=> 
        else
            " Not assigned to variable

            let l:functionWordPosition = matchstrpos(currentLine, "function")
            " execute '/\%'.line(".").'lfunction'
            " execute cursor(matchstrpos(currentLine, "function"))
            :call cursor(line("."), functionWordPosition[1] + 1)
            normal ciwconst
            normal f(i = 
            normal f)a =>

            let a:cursosPositionBeforeIndent = getpos(".")
            normal ==
            :call cursor(a:cursosPositionBeforeIndent[1], a:cursosPositionBeforeIndent[2])
        endif
    else
        " Arrow function

        " Check if assigned to variable, const fn = ()
        " The assignment will be removed, just use: function() 
        " TODO: better check
        if matchstr(currentLine, " = ") == " = "
            if matchstr(currentLine, 'const') == "const"  || matchstr(currentLine, 'let') == "let" 
                 normal 0cefunction
                 normal ==
            endif

            " normal 0cevar
            " normal 0f(ifunction
            normal f=hd3l
            normal f)ldf>

        else
            " Not assigned to variable
            normal 0f>F(ifunction
            normal f)ldf>
        endif

    endif

endfunction

command! ToggleImportsOrientation :call ToggleImportsOrientation()
command! ToggleFuncParamOrientation :call ToggleFuncParamOrientation()
command! -range CommentJsx :call CommentJsx()
