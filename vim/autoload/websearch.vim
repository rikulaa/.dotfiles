" Open web search
function! websearch#Search(searchword)
    " Just search the web if no other option
    let options = ['Choose search engine:', 'https://duckduckgo.com?q=', 'https://google.com/search?q=']
    let input = inputlist(options)

    if (has('macunix'))
        let cmd = 'open'
    elseif (has('unix'))
        let cmd = 'xdg-open'
    endif

    if input != 0
        echo system(cmd . ' ' . shellescape(options[input] . a:searchword))
    endif
endfunction
