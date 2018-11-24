" Changes tag name
function! functions#ChangeTagName()
    let l:newName = input('Rename to: ')

    " get decimal valu of the current character under cursos
	" getline('.') returns the entire line that cursor is sitting on.
	" col('.') returns the column number that the cursor is sitting
	" on.
	" The regular expression \%nc matches a specific given column
	" where n is that column.
	" The '.' regular expression matches exactly one
	" character.

	let dec = char2nr(matchstr(getline('.'), '\%' . col('.') . 'c.'))
    if dec == 60 || dec == 47 
        normal l
    endif

    if dec == 62 
        normal h  
    endif

    let a:cursor_pos_start = getpos(".")

    normal %l

    execute 'normal! "_ciw'.newName
    :call cursor(a:cursor_pos_start[1], a:cursor_pos_start[2])
    execute 'normal! "_ciw'.newName
endfunction


" Adds inputted character to the end of the line without moving the cursor
function! functions#AppendCharacterToEndOfLine()
    let a:cursor_pos_start = getpos(".")
    let c = nr2char(getchar())
    :execute "keepjumps normal! A".c

    " Move cursor back to original position
    call cursor(a:cursor_pos_start[1], a:cursor_pos_start[2])

endfunction
