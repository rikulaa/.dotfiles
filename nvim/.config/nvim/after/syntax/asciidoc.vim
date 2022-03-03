if exists('g:no_vim_conceal') || !has('conceal') || &enc != 'utf-8'
  finish
endif

syn match asciidocURLPrefix "link:[a-zA-Z0-9#:/.-]*\[" conceal cchar=[
syn match asciidocURLPrefix "xref:[a-zA-Z0-9#:/.-]*\[" conceal cchar=[
syn match asciidocTodoDone "\*\s\[x\]" conceal cchar=◎
syn match asciidocTodoUndone "\*\s\[\s\]" conceal cchar=○


hi link asciidocURLPrefix Keyword
hi link asciidocTodoDone Keyword
hi link asciidocTodoUndone Keyword

setlocal conceallevel=1


