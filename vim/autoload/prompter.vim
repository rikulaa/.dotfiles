function! prompter#Show(actions, ...)
    echo "Choose option \n\n"
    for key in keys(a:actions)
        echon "(" | echohl Typedef | echon key | echohl None | echon "): " . a:actions[key]['title'] . "\n"
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
        elseif (has_key(choice, 'menu'))
            call prompter#Show(choice['menu'])
        endif
    endif
endfunction
