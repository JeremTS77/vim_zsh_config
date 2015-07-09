" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    generator_cpp.vim                                  :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: jcalmat <marvin@42.fr>                     +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2015/06/23 13:18:12 by jcalmat           #+#    #+#              "
"    Updated: 2015/06/23 13:18:27 by jcalmat          ###   ########.fr        "
"                                                                              "
" **************************************************************************** "


autocmd	BufNewFile	*.class.cpp		call	Generate_cpp()
autocmd	BufNewFile	*.Class.cpp		call	Generate_cpp()

function! Generate_cpp()
	set paste
	let l:name = expand('%:f')
	let l:inc = expand('%:r')
	let l:cmd = '/usr/bin/basename ' . l:name
	let l:base = expand('%:r:r')
	let l:newname = system(l:cmd)
	let l:newname = toupper(l:newname)
	let l:newname = substitute(l:newname, "\\.", "_", "g")
	let l:newname = substitute(l:newname, "\\n", "", "g")
	exe ":normal A" . "#include \"" . l:inc . ".hpp\"\n"
	exe ":normal A" . "#include <iostream>\n\n"

	exe ":normal A" . "// ╔════════════════╗\n"
	exe ":normal A" . "// ║   CONSTRUCTOR  ║\n"
	exe ":normal A" . "// ╚════════════════╝\n"
	exe "normal A" . "\n"
	exe ":normal A" . l:base . "::" . l:base . "( void )\n{\n\tstd::cout << \"Default constructor called\" << std::endl;\n\treturn ;\n}\n\n"
	exe ":normal A" . l:base . "::" . l:base . "( " . l:base .  " const & rhs )\n{\n\tstd::cout << \"Copy constructor called\" << std::endl;\n\tif (this != &rhs)\n\t\t*this = rhs;\n\treturn ;\n}\n\n"
	exe ":normal A" . l:base . " &\t" . l:base . "::operator=( " . l:base . " const & rhs)\n{\n\tstd::cout << \"Assignation operator called\" << std::endl;\n\tif (this != &rhs)\n\t{" . "\n\t}\n\treturn (*this);\n}\n\n"
	exe ":normal A" . "// ╔════════════════╗\n"
	exe ":normal A" . "// ║   DESTRUCTOR   ║\n"
	exe ":normal A" . "// ╚════════════════╝\n"
	exe "normal A" . "\n"
	exe ":normal A" . l:base . "::~" . l:base . "( void )\n{\n\tstd::cout << \"Destructor called\" << std::endl;\n\treturn ;\n}"
	exe "normal A" . "\n"
	exe ":normal A" . "// ╔════════════════╗\n"
	exe ":normal A" . "// ║    OVERLOAD    ║\n"
	exe ":normal A" . "// ╚════════════════╝\n"
	exe ":normal A" . "\n"
	exe ":normal A" . "std::ostream &\toperator<<(std::ostream & o, " . l:base . "const & src )\n{\n\treturn (o);\n}"
	exe "normal A" . "\n\n"
	exe ":normal A" . "// ╔════════════════╗\n"
	exe ":normal A" . "// ║      OTHER     ║\n"
	exe ":normal A" . "// ╚════════════════╝\n"
	exe ":normal A" . "// ╔════════════════╗\n"
	exe ":normal A" . "// ║    OVERLOAD    ║\n"
	exe ":normal A" . "// ╚════════════════╝\n"
	exe ":normal A" . "// ╔════════════════╗\n"
	exe ":normal A" . "// ║     GETTER     ║\n"
	exe ":normal A" . "// ╚════════════════╝\n"
	exe ":normal A" . "// ╔════════════════╗\n"
	exe ":normal A" . "// ║     SETTER     ║\n"
	exe ":normal A" . "// ╚════════════════╝"
	exe ":4"
	set nopaste
endfunction
