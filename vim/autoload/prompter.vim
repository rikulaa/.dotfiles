function! prompter#Show(actions)
    function! GetChoice(key, val)
        let l:title = get(a:val, 'title')
        return "(" . strcharpart(title, 0, 1) . ")" . strcharpart(title, 1)
    endfunc
    
    execute "10new"
    let w:scratch = 1
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
    call setline(1, split(join(map(values(a:actions), function("GetChoice")), "\t"), "\n"))
    redraw
    let l:choice = getchar()
    let l:targetAction = get(a:actions, nr2char(choice), {})

    execute "wincmd k"

    " Close the scratch window
    for win in range(1, winnr('$'))
        if getwinvar(win, 'scratch')
            execute win . 'windo close'
        endif
    endfor

    " Run the action
    if (has_key(targetAction, 'function'))
        call targetAction['function']()
    elseif (has_key(targetAction, 'command'))
        let l:output = execute(targetAction['command'])
    endif
endfunction
