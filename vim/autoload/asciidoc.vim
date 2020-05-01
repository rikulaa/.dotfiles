" toggle Checkboxes as done or undone
function! asciidoc#toggle_done()
    let doneCheck = '\[x\]'
    let undoneCheck = '\[ \]'

    let savedCursos = getcurpos()
    " Search for checked box in the current line
    try 
        " Go to beginning of line to start the search
        normal 0
        let lineNumber = line('.')
        let isChecked = search(doneCheck, 'n', lineNumber)
        if isChecked == 0
            execute 's/' . undoneCheck . '/' . doneCheck .'/'
        else
            execute 's/' . doneCheck . '/' . undoneCheck  .'/'
        endif
        " restore the cursor position
        call setpos('.', savedCursos)
    catch
        echo "Unable to toggle checkbox!"
    endtry
endfunction

" ================= Promote/demote =================
function! asciidoc#demote_text_obj(c)
    let savedCursos = getcurpos()
    execute 's/^\s\{0,\}' . a:c . '/&' . a:c . '/'
    " restore the cursor position
    call setpos('.', savedCursos)
endfunction

" De-indent text obj
function! asciidoc#promote_text_obj(c)
    let savedCursos = getcurpos()
    execute 's/' . a:c . '\s/ /'
    " restore the cursor position
    call setpos('.', savedCursos)
endfunction

let s:heading = '='
let s:listItem = '*'
let s:listItemOrdered = '.'
function! asciidoc#demote_item()

    let item = getline('.')
    echo item[0]

    if item[0] == s:heading
        call asciidoc#demote_text_obj(s:heading)
    elseif item[0] == s:listItem
        call asciidoc#demote_text_obj('\' . s:listItem)
    elseif item[0] == s:listItemOrdered
        call asciidoc#demote_text_obj('\' . s:listItemOrdered)
    endif
    try
    catch
        echohl WarningMsg | echo "Cannot indent!" | echohl none
    endtry
endfunction!

function! asciidoc#promote_item()
    let item = getline('.')
    echo item[0]

    if item[0] == s:heading
        call asciidoc#promote_text_obj(s:heading)
    elseif item[0] == s:listItem
        call asciidoc#promote_text_obj('\' . s:listItem)
    elseif item[0] == s:listItemOrdered
        call asciidoc#promote_text_obj('\' . s:listItemOrdered)
    endif
    try
    catch
        echohl WarningMsg | echo "Cannot indent!" | echohl none
    endtry
endfunction!
" ================
