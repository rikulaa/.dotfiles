" Netrw by default doesn't delete folders wich have files in them, override
" the default command to force deletion of folders with files
let g:netrw_localrmdir = 'rm -Rf'

let g:netrw_list_hide='^\.\+\/'

" netrw
" Do not show the banner on top
let g:netrw_banner=0

nnoremap <buffer> a echo "Keybinding disabled"
" nunmap <buffer> a
