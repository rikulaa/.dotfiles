" Changes tag name
function! functions#ChangeTagName()
    let l:newName = input('Rename to: ')
    if strlen(newName) == 0
        echo "No name given!"
        return
    endif

    " get decimal valu of the current character under cursos
	" getline('.') returns the entire line that cursor is sitting on.
	" col('.') returns the column number that the cursor is sitting
	" on.
	" The regular expression \%nc matches a specific given column
	" where n is that column.
	" The '.' regular expression matches exactly one
	" character.

    normal F<l
	let dec = char2nr(matchstr(getline('.'), '\%' . col('.') . 'c.'))
    if dec == 60 || dec == 47 
        normal l
    endif

    if dec == 62 
        normal h  
    endif

    let l:cursor_pos_start = getpos(".")

    normal %l

    execute 'normal! "_ct>'.newName
    :call cursor(cursor_pos_start[1], cursor_pos_start[2])
    execute 'normal! "_ct '.newName
endfunction


" Adds inputted character to the end of the line without moving the cursor
function! functions#AppendCharacterToEndOfLine()
    let l:cursor_pos_start = getcurpos()
    let c = nr2char(getchar())
    execute "keepjumps normal! A".c

    " Move cursor back to original position
    call cursor(cursor_pos_start[1], cursor_pos_start[2])

endfunction

" File system helpers
function! functions#DeleteAndCloseBuffer()
    let l:message = "Delete file: " . expand('%')
    let l:confirmation = confirm(message, "&Yes\n&No\n" )
    if confirmation == 1 | call delete(expand('%')) | bd! | endif
endfunction

" Move buffer to {newPath}
function! functions#MoveBuffer(newPath)
    let l:originalPath = expand('%')
    execute "!mv ".originalPath." ".a:newPath
    execute ":e ".a:newPath
    execute ":bd ".l:originalPath
endfunction

" Copy buffer to {newPath}
function! functions#CopyBuffer(newPath)
    let l:originalPath = expand('%')
    :execute "!cp ".originalPath." ".a:newPath
    :execute ":e ".a:newPath
endfunction

function! functions#StripTrailingWhitespace()
    if !&binary && &filetype != 'diff'
        normal mz
        normal Hmy
        %s/\s\+$//e
        normal 'yz<CR>
        normal `z
    endif
endfunction

function! functions#CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)
