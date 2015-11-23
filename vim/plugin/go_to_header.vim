autocmd filetype c,cpp call		Go_to_header()

function! Go_to_header()
	let l:dir1=expand("../includes")
	let l:dir2=expand("../include")
	if isdirectory(l:dir1)
		cd ../includes
	endif
	if isdirectory(l:dir2)
		cd ../include
	endif
endfunction
