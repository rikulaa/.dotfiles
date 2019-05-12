" call PromptWindow("chooce action", [ 
" {'title': "Git" },
" {'title':  "Lint" },
" {'title':  "Test" }
" ])


function! prompter#GetInput()
    return getchar()
endfunction

function! prompter#Show(actions)
    " Close any existing preview windows
    " pclose
    redraw
    set previewheight=5

    let l:promptText = " Choose action"

    function! GetChoice(key, val)
        let l:title = get(a:val, 'title')
        return "(" . strcharpart(title, 0, 1) . ")" . strcharpart(title, 1)
    endfunc

    let l:tmpfile = tempname()

    let l:choices = "&" . join(map(values(a:actions), function("GetChoice")), "\n&") . "\n"

    " Output the options to tmp file and open it on preview
    execute "silent !echo " . shellescape(join(map(values(a:actions), function("GetChoice")), "\t")) " > " . tmpfile
    redraw
    execute "silent pedit " . tmpfile
    redraw

    " Get input from user
    let l:choice = call('prompter#GetInput', [])
    let l:targetAction = get(a:actions, nr2char(choice), {})

    if (has_key(targetAction, 'function'))
        call targetAction['function']()
    elseif (has_key(targetAction, 'command'))
        let l:output = execute(targetAction['command'])
    endif

    " Close the preview window, delete and unload the tmp buffer
    pclose
    set previewheight&
    execute "bd " . tmpfile
    let l:temp = delete(tmpfile)
endfunction

