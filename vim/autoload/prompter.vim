function! prompter#Show(actions, ...)
    let l:cols = get(a:, 1, 1)
    let l:colCount = 0

    echo "Choose option \n\n"
    for key in keys(a:actions)
        let l:breakLine = (l:colCount + 1) % l:cols == 0 ? "\n" : "\t"
        echon "(" | echohl Typedef | echon key | echohl None | echon "): " . a:actions[key]['title'] . l:breakLine
        let l:colCount += 1
    endfor
    echo "\n"

    let l:input = nr2char(getchar())

    redraw!

    if (has_key(a:actions, input))
        let l:choice = a:actions[input]
        if (has_key(choice, 'function'))
            call choice['function']()
        elseif (has_key(choice , 'command'))
            execute(choice['command'])
        endif
    endif
endfunction
