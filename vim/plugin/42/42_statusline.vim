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
"                       <jelefebv@student.42.fr>                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" #      

hi! User1			ctermbg=231 ctermfg=238 cterm=bold
hi! User2			ctermbg=240 ctermfg=0
hi! User3			ctermbg=22 ctermfg=15
hi! User4			ctermbg=28 ctermfg=15
hi! User5			ctermbg=238 ctermfg=15
hi! User6			ctermbg=236 ctermfg=15
hi! User7			ctermbg=130 ctermfg=231
hi! User8			ctermbg=245 ctermfg=232 cterm=bold

set statusline=
set statusline+=%1*\ %t\ %*
set statusline+=%2*%=%*
set statusline+=%4*\ %{Line_Count()}/80\ %*
set statusline+=%5*\ %3l/%3L\ %*
set statusline+=%6*\ %{Paste()}\ %*
set statusline+=%7*\ %{Input()}\ %*
set statusline+=%8*\ [%Y]\ %*
set statusline+=%9*\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}\ %*

"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

autocmd Filetype c,cpp call StatusLine_C()

function! StatusLine_C()
	set statusline=
	set statusline+=%1*\ %t\ %*
	set statusline+=%2*%=%*
	set statusline+=%3*%{Line_Func()}%*
	set statusline+=%4*\ %{Line_Count()}/80\ %*
	set statusline+=%5*\ %3l/%3L\ %*
	set statusline+=%6*\ %{Paste()}\ %*
	set statusline+=%7*\ %{Input()}\ %*
	set statusline+=%8*\ [%Y]\ %*
	set statusline+=%9*\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}\ %*
endfunction

au InsertLeave * call	Input()

let g:line_func = 0
let g:line_caract = 0
let g:last_state = ""
let g:last_color_line_func = ""
let g:last_color_line_caract = ""
let g:ismodifed = 0

function! PrePad(s,amt,...)
	if a:0 > 0
		let char = a:1
	else
		let char = ' '
	endif
	return repeat(char, a:amt - len(a:s)) . a:s
endfunction

function! Line_Func()
	let g:line_func = -1
	let ligne = line('.')
	while empty(matchstr(getline(ligne), '^{'))
		if ligne < 1
			let g:line_func = -1
			return ""
		endif
		if !empty(matchstr(getline(ligne), '^}'))
			let g:line_func = -1
			return ""
		endif
		let ligne -= 1
	endwhile
	while empty(matchstr(getline(ligne), '^}$'))
		if ligne == line('$')
			let g:line_func = -1
			return ""
		endif
		if !empty(matchstr(getline(ligne), '^}.*;'))
			let g:line_func = -1
			return ""
		endif
		let ligne += 1
		let g:line_func += 1
	endwhile
	return "\ ".PrePad(g:line_func, 2)."/25 "
endfunction

function! Line_Count()
	let g:line_caract = virtcol('$') - 1
	return PrePad(g:line_caract, 2)
endfunc

function! Paste()
	let passed = &paste
	if passed == 1
		return " PASTE "
	else
		return "NOPASTE"
	endif
endfunction

function! Color_to_insert()
	let l:modifier = &modified
	hi! User1			ctermbg=238 ctermfg=231 cterm=bold
	if l:modifier == 0
		hi! User2			ctermbg=24 ctermfg=0
	else
		hi! User2			ctermbg=229 ctermfg=0
	endif
	if g:line_func > 25
		hi! User3		ctermbg=160 ctermfg=15
	else
		hi! User3		ctermbg=22 ctermfg=15
	endif
	if g:line_caract > 80
		hi! User4		ctermbg=160 ctermfg=15
	else
		hi! User4		ctermbg=28 ctermfg=15
	endif
	hi! User5			ctermbg=31 ctermfg=15
	hi! User6			ctermbg=117 ctermfg=23
	hi! User7			ctermbg=231 ctermfg=23 cterm=bold
	hi! User8			ctermbg=245 ctermfg=232 cterm=bold
endfunction

function! Color_to_visual()
	let l:modifier = &modified
	hi! User1			ctermbg=238 ctermfg=231 cterm=bold
	if l:modifier == 0
		hi! User2			ctermbg=70 ctermfg=0
	else
		hi! User2			ctermbg=229 ctermfg=0
	endif
	if g:line_func > 25
		hi! User3		ctermbg=160 ctermfg=15
	else
		hi! User3		ctermbg=22 ctermfg=15
	endif
	if g:line_caract > 80
		hi! User4		ctermbg=160 ctermfg=15
	else
		hi! User4		ctermbg=28 ctermfg=15
	endif
	hi! User5			ctermbg=22 ctermfg=148
	hi! User6			ctermbg=70 ctermfg=22
	hi! User7			ctermbg=148 ctermfg=22 cterm=bold
	hi! User8			ctermbg=245 ctermfg=232 cterm=bold
endfunction

function! Color_to_normal()
	let l:modifier = &modified
	hi! User1			ctermbg=238 ctermfg=231 cterm=bold
	if l:modifier == 0
		hi! User2			ctermbg=236 ctermfg=0
	else
		hi! User2			ctermbg=229 ctermfg=0
	endif
	if g:line_func > 25
		hi! User3		ctermbg=196 ctermfg=15
	else
		hi! User3		ctermbg=22 ctermfg=15
	endif
	if g:line_caract > 80
		hi! User4		ctermbg=160 ctermfg=15
	else
		hi! User4		ctermbg=28 ctermfg=15
	endif
	hi! User5			ctermbg=238 ctermfg=15
	hi! User6			ctermbg=236 ctermfg=15
	hi! User7			ctermbg=130 ctermfg=231
	hi! User8			ctermbg=245 ctermfg=232 cterm=bold
endfunction

function! Input()
	let mode = mode()
	let string = '??????'
	if mode == 'v' || mode == 'V'
		let string = "VISUAL"
	elseif mode == 'i'
		let string = "INSERT"
	elseif mode == 'n'
		let string = "NORMAL"
	endif
	if (g:ismodifed != &modified) || (mode != g:last_state) || (g:line_func != g:last_color_line_func) || (g:line_caract > 80 && g:last_color_line_caract <= 80) || (g:line_caract <= 80 && g:last_color_line_caract > 80)
		call Refresh_status_line()
	endif
	let g:ismodifed = &modified
	let g:last_state = mode
	let g:last_color_line_func = g:line_func
	let g:last_color_line_caract = g:line_caract
	return string
endfunction

function! Refresh_status_line()
	let mode = mode()
	if mode == 'v' || mode == 'V'
		call Color_to_visual()
	elseif mode == 'i'
		call Color_to_insert()
	elseif mode == 'n'
		call Color_to_normal()
	endif
endfunction

autocmd Filetype c,cpp call Key_C()

" No Bug

function Key_C()
	imap <silent><C-N> <C-N>
	imap <expr> <silent> <C-P> pumvisible() ? "\<Up>" : "\<C-X>\<C-I>\<Up>"
	imap <expr> <silent> <C-L> pumvisible() ? "\<Up>" : "\<C-X>\<C-K>\<Up>"
	imap <expr> <silent> <C-O> pumvisible() ? "\<Up>" : "\<C-X>\<C-L>\<Up>"
	imap <expr> <silent> <C-End> pumvisible() ? "\<Up>" : "\"\"\<Left>\<C-X>\<C-F>\<Up>"
endfunction
