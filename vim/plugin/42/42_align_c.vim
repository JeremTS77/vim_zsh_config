""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"        ________ ++     ________                                "
"       /VVVVVVVV\++++  /VVVVVVVV\                               "
"       \VVVVVVVV/++++++\VVVVVVVV/                               "
"        |VVVVVV|++++++++/VVVVV/'                                "
"        |VVVVVV|++++++/VVVVV/'              :::      ::::::::   "
"       +|VVVVVV|++++/VVVVV/'+             :+:      :+:    :+:   "
"     +++|VVVVVV|++/VVVVV/'+++++         +:+ +:+         +:+     "
"   +++++|VVVVVV|/VVVVV/'+++++++++     +#+  +:+       +#+        "
"     +++|VVVVVVVVVVV/'+++++++++     +#+#+#+#+#+   +#+           "
"       +|VVVVVVVVV/'+++++++++           #+#    #+#              "
"        |VVVVVVV/'+++++++++            ###   ########.fr        "
"        |VVVVV/'+++++++++                                       "
"        |VVV/'+++++++++                                         "
"        'V/'   ++++++                                           "
"                 ++                                             "
"                       <mblet@student.42.fr>                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use : Shift + TAB                                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map  <silent> <S-Tab>	:call Preserve("normal gg=G")<CR>gi
imap <silent> <S-Tab>	<Esc>:call Preserve("normal gg=G")<CR>gi
vmap <silent> <S-Tab>	<Esc>:call Preserve("normal gg=G")<CR>gi

autocmd Filetype c,cpp	call Align_Map()

function! Align_Map()
	map  <silent> <S-Tab>	:call Align_42()<CR>gi
	imap <silent> <S-Tab>	<Esc>:call Align_42()<CR>gi
	vmap <silent> <S-Tab>	<Esc>:call Align_42()<CR>gi
endfunction

function! Preserve(command)
  let last_search=@/
  let save_cursor = getpos(".")
  normal H
  let save_window = getpos(".")
  call setpos('.', save_cursor)
  execute a:command
  let @/=last_search
  call setpos('.', save_window)
  normal zt
  call setpos('.', save_cursor)
endfunction

function! Align_42()
	call Preserve("normal gg=G")
	let l:winview = winsaveview()
	%s/\s\+$//e
	%s/\"/?????/eg
	%s/\//|||||/eg
	silent g/^\_$\n\_^$/d
	call Align_All()
	%s/?????/\"/eg
	%s/|||||/\//eg
	call winrestview(l:winview)
	call system("rm -fr ~/.vim/view")
endfunction

function! Align_speed_42()
	%s/\s\+$//e
	%s/\"/?????/eg
	%s/\//|||||/eg
	call Speed_Align_Func()
	%s/?????/\"/eg
	%s/|||||/\//eg
endfunction

function! Get_len_var(s)
	let l:cmd = "basename \"" . a:s . "\" | wc -c | awk '{print $1}' | tr -d '\n'"
	let l:num = system(l:cmd)
	let l:ret = col("$") - l:num - 2
	return l:ret
endfunction

function! Get_len_func(s)
	let l:cmd = "basename \"" . a:s . "\" | wc -c | awk '{print $1}' | tr -d '\n'"
	let l:num = system(l:cmd)
	let l:ret = col("$") - l:num - 1
	return l:ret
endfunction

function! Get_len_speed_func(s)
	let l:cmd = "basename \"" . a:s . "\" | wc -c | awk '{print $1}' | tr -d '\n'"
	let l:num1 = system(l:cmd)
	let l:num1 = col("$") - l:num1 - 2
	let l:cmd = "dirname \"" . a:s . "\" | tr -dc '\\t' | wc -c | awk '{print $1}' | tr -d '\n'"
	let l:num2 = system(l:cmd)
	let l:ret = l:num1 + ((l:num2 - 1) * (&tabstop - 1))
	return l:ret
endfunction

function! Speed_Align_Func()
	let l:maxlen_struct = 0
	let l:lenlignes = 0
	let l:tmplen = 0
	let l:line = 0
	while l:line <= line('$')
		if !empty(matchstr(getline(l:line), '^\i.*(.*'))
			"""""Align Function"""""
			call cursor(l:line, 1)
			s/\s\+\ze\**\i*(.*\(^\t\)\@<!/\//e
			let l:maxlen_struct = Get_len_func(getline(l:line))
			execute uu
			break
		elseif !empty(matchstr(getline(l:line), '^\i.*'))
			"""""Align Structur"""""
			call cursor(l:line, 1)
			s/\s\+\zs\**\i\+;*$/\/ /e
			let l:maxlen_struct = Get_len_speed_func(getline(l:line))
			execute uu
			break
		endif
		let l:line += 1
	endwhile
	let l:line = 0
	while l:line <= line('$')
		let l:lenlignes = 0
		let l:tmplen = 0
		if !empty(matchstr(getline(l:line), '^\i.*(.*'))
			call cursor(l:line, 1)
			s/\s\+\ze\**\i*(.*\(^\t\)\@<!/\//e
		endif
		let l:line += 1
	endwhile
	let l:line = 0
	if (l:maxlen_struct % &tabstop) > 2
		let l:maxlen_struct += &tabstop
	endif
	while l:line <= line('$')
		if !empty(matchstr(getline(l:line), '^\i.*(.*'))
			"""""Align Function"""""
			call cursor(l:line, 1)
			let l:tmplen = Get_len_func(getline(l:line))
			if l:maxlen_struct > l:tmplen
				let l:ntab = 0
				let l:diff = l:maxlen_struct - l:tmplen
				if l:tmplen < &tabstop
					let l:ntab += 1
					let l:ntab += (l:diff - (&tabstop - l:tmplen)) / &tabstop
				elseif (l:tmplen % &tabstop) > 0
					let l:ntab += (l:diff + l:tmplen % &tabstop) / &tabstop
				else
					let l:ntab += (l:diff) / &tabstop
				endif
				let l:ntab += 1
				s/\//\=repeat("\t", l:ntab)/e
			else
				s/\//\t/e
			endif
		endif
		let l:line += 1
	endwhile
endfunction

function!	Align_All()
	"""""Align Variable"""""
	let l:maxlen_var = 0
	"""""Align Function"""""
	let l:maxlen_func = 0
	"""""Align Structur"""""
	let l:maxlen_struct = 0
	let l:line = 0
	while l:line <= line('$')
		let l:lenlignes = 0
		let l:tmplen = 0
		if !empty(matchstr(getline(l:line), '^\i.*(.*'))
			"""""Align Function"""""
			call cursor(l:line, 1)
			s/\s\+\ze\**\i*(.*\(^\t\)\@<!/\//e
			let l:tmplen = Get_len_func(getline(l:line))
			if l:tmplen > l:maxlen_func
				let l:maxlen_func = l:tmplen
			endif
		elseif !empty(matchstr(getline(l:line), '^\i.*'))
			"""""Align Structur"""""
			call cursor(l:line, 1)
			s/\s\+\ze\**\i\+;*$/\//e
			let l:tmplen = Get_len_func(getline(l:line))
			if l:tmplen > l:maxlen_struct
				let l:maxlen_struct = l:tmplen
			endif
		elseif !empty(matchstr(getline(l:line), '^}.*;$'))
			"""""Align Structur"""""
			call cursor(l:line, 1)
			s/\s\+\ze\**\i\+;$/\//e
			let l:tmplen = l:maxlen_var + &tabstop - 1
			if l:tmplen > l:maxlen_struct
				let l:maxlen_struct = l:tmplen
			endif
		elseif !empty(matchstr(getline(l:line), '^{$'))
			"""""Align Variable"""""
			let l:line += 1
			let l:lenlines = 0
			let l:maxlen_var = 0
			while !empty(matchstr(getline(l:line), '^\t.*')) && l:line <= line('$')
				let l:line += 1
				let l:lenlines += 1
			endwhile
			if empty(matchstr(getline(l:line), '^}$'))
				let l:line = l:line - l:lenlines
				while !empty(matchstr(getline(l:line), '^\t.*')) && l:line <= line('$')
					call cursor(l:line, 1)
					s/\s\+\ze\(\(\**\S\+\( [\+\-\*\/\=\%\&\|]\+ \S\+\)*\)\|\(\**(.*)\)\);\(^\t\)\@<!/\//e
					let l:tmplen = Get_len_var(getline(l:line))
					if l:tmplen > l:maxlen_var
						let l:maxlen_var = l:tmplen
					endif
					let l:line += 1
				endwhile
				if (l:maxlen_var % &tabstop) > 2
					let l:maxlen_var += &tabstop
				endif
				let l:line = l:line - l:lenlines
				while !empty(matchstr(getline(l:line), '^\t.*')) && l:line <= line('$')
					call cursor(l:line, 1)
					let l:tmplen = Get_len_var(getline(l:line))
					if l:maxlen_var > l:tmplen
						let l:ntab = 0
						let l:diff = l:maxlen_var - l:tmplen
						if l:tmplen < &tabstop
							let l:ntab += 1
							let l:ntab += (l:diff - (&tabstop - l:tmplen)) / &tabstop
						elseif (l:tmplen % &tabstop) > 0
							let l:ntab += (l:diff + l:tmplen % &tabstop) / &tabstop
						else
							let l:ntab += (l:diff) / &tabstop
						endif
						let l:ntab += 1
						s/\//\=repeat("\t", l:ntab)/e
					else
						s/\//\t/e
					endif
					let l:line += 1
				endwhile
				let l:line -= 1
			endif
		endif
		let l:line += 1
	endwhile
	let l:line = 0
	if (l:maxlen_struct % &tabstop) > 2
		let l:maxlen_struct += &tabstop
	endif
	if (l:maxlen_func % &tabstop) > 2
		let l:maxlen_func += &tabstop
	endif
	if (l:maxlen_struct > &tabstop)
		let l:maxlen_func = l:maxlen_struct
	endif
	while l:line <= line('$')
		if !empty(matchstr(getline(l:line), '\t\+||')) || !empty(matchstr(getline(l:line), '\t\+&&'))
			call cursor(l:line, 1)
			s/^\t//e
		elseif !empty(matchstr(getline(l:line), '^\i.*(.*'))
			"""""Align Function"""""
			call cursor(l:line, 1)
			let l:tmplen = Get_len_func(getline(l:line))
			if l:maxlen_func > l:tmplen
				let l:ntab = 0
				let l:diff = l:maxlen_func - l:tmplen
				if l:tmplen < &tabstop
					let l:ntab += 1
					let l:ntab += (l:diff - (&tabstop - l:tmplen)) / &tabstop
				elseif (l:tmplen % &tabstop) > 0
					let l:ntab += (l:diff + l:tmplen % &tabstop) / &tabstop
				else
					let l:ntab += (l:diff) / &tabstop
				endif
				let l:ntab += 1
				s/\//\=repeat("\t", l:ntab)/e
			else
				s/\//\t/e
			endif
		elseif !empty(matchstr(getline(l:line), '^\i.*'))
			"""""Align Structur"""""
			call cursor(l:line, 1)
			let l:tmplen = Get_len_func(getline(l:line))
			if l:maxlen_struct > l:tmplen
				let l:ntab = 0
				let l:diff = l:maxlen_struct - l:tmplen
				if l:tmplen < &tabstop
					let l:ntab += 1
					let l:ntab += (l:diff - (&tabstop - l:tmplen)) / &tabstop
				elseif (l:tmplen % &tabstop) > 0
					let l:ntab += (l:diff + l:tmplen % &tabstop) / &tabstop
				else
					let l:ntab += (l:diff) / &tabstop
				endif
				let l:ntab += 1
				s/\//\=repeat("\t", l:ntab)/e
			else
				s/\//\t/e
			endif
		elseif !empty(matchstr(getline(l:line), '^{$'))
			"""""Align Structur"""""
			let l:line += 1
			let l:lenlines = 0
			while !empty(matchstr(getline(l:line), '^\t.*')) && l:line <= line('$')
				if !empty(matchstr(getline(l:line), '\t\+||')) || !empty(matchstr(getline(l:line), '\t\+&&'))
					call cursor(l:line, 1)
					s/^\t//e
				endif
				let l:line += 1
				let l:lenlines += 1
			endwhile
			if !empty(matchstr(getline(l:line), '^}.*;$'))
				let l:line = l:line - l:lenlines
				while !empty(matchstr(getline(l:line), '^\t.*')) && l:line <= line('$')
					call cursor(l:line, 1)
					s/\s\+\ze\(\(\**\S\+\( [\+\-\*\/\=\%\&\|]\+ \S\+\)*\)\|\(\**(.*)\)\);\(^\t\)\@<!/\//e
					let l:line += 1
				endwhile
				let l:line = l:line - l:lenlines
				while !empty(matchstr(getline(l:line), '^\t.*')) && l:line <= line('$')
					call cursor(l:line, 1)
					let l:tmplen = Get_len_var(getline(l:line))
					if (l:maxlen_struct - &tabstop) > l:tmplen
						let l:ntab = 0
						let l:diff = (l:maxlen_struct - &tabstop) - l:tmplen
						if l:tmplen < &tabstop
							let l:ntab += 1
							let l:ntab += (l:diff - (&tabstop - l:tmplen)) / &tabstop
						elseif (l:tmplen % &tabstop) > 0
							let l:ntab += (l:diff + l:tmplen % &tabstop) / &tabstop
						else
							let l:ntab += (l:diff) / &tabstop
						endif
						let l:ntab += 1
						s/\//\=repeat("\t", l:ntab)/e
					else
						s/\//\t/e
					endif
					let l:line += 1
				endwhile
				let l:line -= 1
			endif
		elseif !empty(matchstr(getline(l:line), '^}.*;$'))
			"""""Align Structur"""""
			call cursor(l:line, 1)
			let l:tmplen = 1
			if l:maxlen_struct > l:tmplen
				let l:ntab = 0
				let l:diff = l:maxlen_struct - l:tmplen
				if l:tmplen < &tabstop
					let l:ntab += 1
					let l:ntab += (l:diff - (&tabstop - l:tmplen)) / &tabstop
				elseif (l:tmplen % &tabstop) > 0
					let l:ntab += (l:diff + l:tmplen % &tabstop) / &tabstop
				else
					let l:ntab += (l:diff) / &tabstop
				endif
				let l:ntab += 1
				s/\//\=repeat("\t", l:ntab)/e
			else
				s/\//\t/e
			endif
		endif
		let l:line += 1
	endwhile
endfunction
