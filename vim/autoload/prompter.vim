" call PromptWindow("chooce action", [ 
" {'title': "Git" },
" {'title':  "Lint" },
" {'title':  "Test" }
" ])
function! prompter#Show(actions)
    let l:promptText = " Choose action"

    function! GetChoice(key, val)
        return a:val['title']
    endfunc
    let l:choices = "&" . join(map(copy(a:actions), function("GetChoice")), "\n&") . "\n"

    let l:choice = confirm(promptText, choices) 

    let l:targetAction = a:actions[ choice - 1 ]

    if (has_key(targetAction, 'function'))
        let l:output = call(targetAction['function'])
    elseif (has_key(targetAction, 'command'))
        let l:output = execute(targetAction['command'])
    endif
endfunction

