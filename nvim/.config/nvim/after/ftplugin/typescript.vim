set shiftwidth=2
try
	let s:ls = globpath(&rtp,'node_modules/.bin/typescript-language-server',1)
	let s:ls = split(s:ls,"\n")[0]

	" register and start language server
	call LanguageClient_registerServerCommands({'typescript':[ s:ls, '--stdio' ]})
	" LanguageClientStart
catch
	" do nothing
    echom "Cannot start typescript-language-server"
endtry

if expand('%:ph') =~ 'procaravan/search-agent' 
    augroup formathook
        autocmd!
        " Format the buffer
        autocmd BufWritePost *.ts silent !yarn f %
    augroup END
endif
