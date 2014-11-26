autocmd BufWritePost	*.c		call	Actualise_makefile()
autocmd BufWritePost	*.h		call	Actualise_makefile()

function! Actualise_makefile()
	let l:pwd = getcwd()
	exe ':cd ..'
	if filereadable('./Makefile')
		exe ":sp " . "Makefile"
		call Refresh_files_list()
		:set hidden
		:setl autoread
		:silent! wq
		:silent! exe "bd 2"
	endif
	exe ':cd'.l:pwd
endfunction
