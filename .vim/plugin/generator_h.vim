" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    generator_h.vim                                    :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: jcalmat <marvin@42.fr>                     +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2015/06/20 13:57:33 by jcalmat           #+#    #+#              "
"    Updated: 2015/06/24 17:12:47 by jcalmat          ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

autocmd	BufNewFile	*.h		call	Generate_h_42()
autocmd	BufNewFile	*.hpp	call	Generate_hpp()
autocmd BufNewFile	*.php	call	Generate_php()

function! Generate_h_42()
	set paste
	let l:name = expand('%:f')
	let l:cmd = '/usr/bin/basename ' . l:name
	let l:newname = system(l:cmd)
	let l:newname = toupper(l:newname)
	let l:newname = substitute(l:newname, "\\.", "_", "g")
	let l:newname = substitute(l:newname, "\\n", "", "g")
	exe ":normal A" . "#ifndef " . l:newname . "\n# define " . l:newname . "\n\n\n\n#endif"
	"" /* !" . l:newname . " */"
	if exists("*Insert_header_42")
		call Insert_header_42()
		exe ":16"
	els
		exe ":4"
	endif
	set nopaste
endfunction

function! Generate_php()
	exe ":normal A" . "!/usr/bin/php\n<?php\n\n?>"
	%s/!/#!/e
	exe ":3"
endfunction

function! Generate_hpp()
	set paste
	let l:name = expand('%:f')
	let l:cmd = '/usr/bin/basename ' . l:name
	let l:base = expand('%:r:r')
	let l:newname = system(l:cmd)
	let l:newname = toupper(l:newname)
	let l:newname = substitute(l:newname, "\\.", "_", "g")
	let l:newname = substitute(l:newname, "\\n", "", "g")
	exe ":normal A" . "#ifndef " . l:newname . "\n# define " . l:newname . "\n\n# include <iostream>\n\nclass " . l:base .  " {\n\npublic:\n\n\t" . l:base . "( void );\n\t" . l:base . "( " . l:base . " const & rhs);\n\n\t" . l:base . " &\toperator=( " . l:base . " const & rhs );\n\n\t~" . l:base . "( void );\n\nprivate:\n\n};\n\n"
	exe "normal A" . "std::ostream &\toperator<<( std::ostream & o, " . l:base . " const & src );"
	exe "normal A" . "\n\n#endif"
	exe ":4"
	set nopaste
endfunction
