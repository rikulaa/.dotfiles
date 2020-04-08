" Open web search
function! websearch#Search(searchword)
    let searchpattern = a:searchword
    if strlen(searchpattern) == 0
        let searchpattern = input('Websearch: ')
        if strlen(searchpattern) == 0
            return
        endif
        echo "\n"
    endif
    " Just search the web if no other option
    let options = ['Choose search engine:', 'https://duckduckgo.com?q=', 'https://google.com/search?q=']
    let selectedEngine = inputlist(options)

    if (has('macunix'))
        let cmd = 'open'
    elseif (has('unix'))
        let cmd = 'xdg-open'
    endif

    if selectedEngine != 0
        echo system(cmd . ' ' . shellescape(options[selectedEngine] . searchpattern))
    endif
endfunction
