function! prompter#RenderLine(row, l)
    call append(a:row, a:l)
endfunction

function! prompter#Show(actions)
    " Create the window
    let l:height = len(keys(a:actions)) + 3
    execute "belowright" . height . "new MENU"
    let w:menu = 1
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile

    call append(0, "Choose option...")
    call append(1, "")

    let l:output = ""

    let l:lineoffset = 2

    let l:index = 0
    for key in keys(a:actions)
        let l:output = "(" . key . ") " . a:actions[key]['title'] .  "\t"
        call prompter#RenderLine(lineoffset, output)
        let l:lineoffset += 1
    endfo
    redraw!

    let l:input = ""
    try
        echo ""
        let l:input = nr2char(getchar())
    catch
        " Silenty fail if user presses <ctrl-c> (escape characters)
    endtry

    " Close the menu window
    for win in range(1, winnr('$'))
        if getwinvar(win, 'menu')
            execute win . 'windo close'
            break
        endif
    endfor

    execute "wincmd k"

    " Run the action if we can find the corresponding entry for the input
    if (has_key(a:actions, input))
        let l:selection = a:actions[input]
        if (has_key(selection, 'function'))
            call selection['function']()
        elseif (has_key(selection, 'command'))
            let l:output = execute(selection['command'])
        elseif (has_key(selection, 'menu'))
            call prompter#Show(selection['menu'])
        endif
    endif
endfunction
