# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    .zshrc                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jelefebv <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/06/16 14:00:31 by jelefebv          #+#    #+#              #
#    Updated: 2015/06/16 14:02:00 by jelefebv         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

stty -ixon
export PATH=$PATH:~/bin:~/.brew/bin
unsetopt beep

if [[ -f ~/\#_my_config/prompt.zsh ]]; then
	source ~/\#_my_config/prompt.zsh
fi

# ╔════════════════╗
# ║       KEY      ║
# ╚════════════════╝

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;2H" kill-region
bindkey "^[[1;2D" backward-word
bindkey "^[[1;2C" forward-word

# ╔════════════════╗
# ║   COMPLETION   ║
# ╚════════════════╝

autoload -U compinit && compinit
zmodload zsh/complist

export LS_COLORS='di=0;34:ln=35:so=32:pi=0;33:ex=32:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;34:ow=0;34:'
zstyle ':completion:*' menu select=0
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

bindkey -M menuselect '^[[Z' reverse-menu-complete
bindkey -M menuselect '^M' .accept-line

# ╔════════════════╗
# ║      ALIAS     ║
# ╚════════════════╝

function cdls()
{
	local locallast
	local localhome
	if [ $# -eq 0 ]; then
		cd
	else
		if [[ $1 == *.c ]]; then
			if [ `dirname $1 | wc -c` -gt '2' ]; then
				locallast=`basename $1`
				localhome=`echo $1`
				localhome=`echo $1 | sed 's/\(.*\)'${locallast}'/\1/'`
				cd $localhome
				vi $locallast
			else
				vi $1
			fi
		elif [[ $1 == *.h ]]; then
			if [ `dirname $1 | wc -c` -gt '2' ]; then
				locallast=`basename $1`
				localhome=`echo $1`
				localhome=`echo $1 | sed 's/\(.*\)'${locallast}'/\1/'`
				cd $localhome
				vi $locallast
			else
				vi $1
			fi
		else
			cd $*
		fi
	fi
	localhome=`echo $PWD | sed 's/'"${HOME//\//\\/}"'//'`
	if [[ -n $localhome ]]; then
		ls -a -G
	else
		ls -G
	fi
}

function pdf_func()
{
	if [ $# -eq 0 ]; then
		open ~/pdf
	else
		open ~/pdf/$1
	fi
}

function vicd()
{
	local locallast
	local localhome
	if [ $# -eq 0 ]; then
		ls -a -G
	elif [ -d "$1" ];then
		cdls $1
	else
		if [ `dirname $1 | wc -c` -gt '2' ]; then
			locallast=`basename $1`
			localhome=`echo $1`
			localhome=`echo $1 | sed 's/\(.*\)'${locallast}'/\1/'`
			cd $localhome
			vi $locallast
		else
			vi $1
		fi
	fi
}

function lss()
{
	local localhome=`echo $PWD | sed 's/'"${HOME//\//\\/}"'//'`
	if [ $# -eq 0 ]; then
		if [[ -n $localhome ]]; then
			ls -a -G
		else
			ls -G
		fi
	else
		ls -G $*
	fi
}

function rmfast()
{
	if [ -d $* ]; then
		rm -fr $* && ls -a -G
	else
		rm -i $* && ls -a -G
	fi
}

function mycat()
{
	cat $* | expand -t4
}

function mkdircd()
{
	mkdir $*
	cdls $*
}

function ftgitp()
{
	if [ $# -eq 0 ]; then
		git add --all && git commit -m "refresh git" && git push origin master && git ls-files
	else
		git add --all && git commit -m "$*" && git push origin master && git ls-files
	fi
}

function ftgitc()
{
	local filename=`echo $1 | rev | cut -d/ -f2 | rev`
	if [ $# -eq 1 ]; then
		git clone "$1" $filename && cdls $filename
	else
		git clone "$1" "$2" && cdls "$2"
	fi
}

function correction()
{
	if [ $# -eq 0 ]; then
		cd ~/correction
		ls -a -G
	else
		local filename1=`echo $1 | rev | cut -d/ -f2 | rev`
		local filename2=`echo $1 | rev | cut -d/ -f1 | rev`
		cd ~/correction
		if [ ! -d $filename2 ]; then
			mkdir $filename2
		fi
		cd $filename2
		git clone "$1" $filename1
		cd $filename1
		ls -la -G
		cat -e auteur
	fi
}

function norme()
{
	if [ $# -eq 0 ]; then
		dot_c=`find . -iname "*.c"`
		dot_h=`find . -iname "*.h"`
		norminette $dot_c $dot_h
	else
		norminette $*
	fi
}

function mylockscreen()
{
	if [ $# -eq 0 ]; then
		defaults -currentHost write com.apple.ScreenSaver.Basic MESSAGE ""
	else
		defaults -currentHost write com.apple.ScreenSaver.Basic MESSAGE $1
	fi
	open -a '/System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app'
}

function gcc3d()
{
	gcc -Wall -Werror -Wextra "$*" -L/usr/lib -lmlx -framework OpenGL -framework AppKit && ./a.out
}

function cauteur()
{
	echo $USER > auteur && git add auteur && git commit -m "add auteur" && git push origin master
}

function libft_cp()
{
	cp -r ~/InWork/ft_sh2/libft ./libft
	mv ./libft/includes/*.h ./includes/
	rm -rf ./libft/includes
}

function speedstart()
{
	mkdir includes/
	mkdir srcs
	libft_cp
	echo "" > .gitignore
#	echo "includes/libft.h" >> .gitignore
	vi Makefile
}

function sqlf_file()
{
	if [ $# -eq 2 ]; then
		~/mamp/mysql/bin/mysql -uroot -pyeueteyeieoeuei -t -vvv $1 < "$2" | more | expand -t4
	elif [ $# -eq 1 ]; then
		~/mamp/mysql/bin/mysql -uroot -pyeueteyeieoeuei -t -vvv < "$1" | more | expand -t4
	else
		echo "Hey gros con oublie pas le fichier."
	fi
}

function clear_cache()
{
	find ~ -name ".DS_Store" -exec rm {} \;
	rm -rf ~/Library/Caches
	rm -rf ~/Library/Keychains
	rm -rf ~/Library/Google
	rm -rf ~/Library/Cookies
	rm -rf ~/Library/Logs
	rm -rf ~/Library/Account
	rm -rf ~/Desktop/FL\ Studio.app;clear
}

function logout_func()
{
	clear_cache
	echo "Done."
	exec /Applications/helper.app/Contents/MacOS/helper logout
}

function pwdsave()
{
	echo "$PWD" > ~/.pwd
}

function cdsave()
{
	cd `cat ~/.pwd`
}

# ╔════════════════╗
# ║       CD       ║
# ╚════════════════╝


alias cd='cdls'
alias ..='cd ..'
alias /.='cd -'
alias cd..='cd ..'

alias xs='cd'

# ╔════════════════╗
# ║       MK       ║
# ╚════════════════╝

alias mk='mkdircd'

# ╔════════════════╗
# ║     LOGOUT     ║
# ╚════════════════╝

alias logout='logout_func'

# ╔════════════════╗
# ║       PHP      ║
# ╚════════════════╝


alias php='~/mamp/php/bin/php'

# ╔════════════════╗
# ║      CAT       ║
# ╚════════════════╝

alias cat='mycat'

# ╔════════════════╗
# ║      CLR       ║
# ╚════════════════╝

alias clr='clear_cache'

# ╔════════════════╗
# ║       LS       ║
# ╚════════════════╝

alias ls='ls -G'
alias ll='ls -lhaG'

# ╔════════════════╗
# ║      GCC       ║
# ╚════════════════╝

alias gcw='gcc -Wall -Werror -Wextra'
alias gcc3d='gcc3d'
alias gci='gcc -I .'

# ╔════════════════╗
# ║      GIT       ║
# ╚════════════════╝

alias gti='git'
alias fgit='ftgitp'
alias cgit='ftgitc'
alias gll='git ls-files'

# ╔════════════════╗
# ║     MACRO      ║
# ╚════════════════╝

alias speedstart='speedstart'

# ╔════════════════╗
# ║    VIM EDIT    ║
# ╚════════════════╝

alias vrc='vi ~/\#_my_config/.myvimrc;cd -'
alias syntax='vi ~/.vim/syntax/c.vim;cd -'

alias -s c='vim'
alias -s h='vim'
alias -s vim='vim'

# ╔════════════════╗
# ║   GIT AUTEUR   ║
# ╚════════════════╝

alias autor='cauteur'

# ╔════════════════╗
# ║      PDF       ║
# ╚════════════════╝

alias pdf='pdf_func'

# ╔════════════════╗
# ║     NORME      ║
# ╚════════════════╝

alias save_pwd='pwdsave'
alias /='cdsave'

# ╔════════════════╗
# ║     NORME      ║
# ╚════════════════╝

alias vinorme='vi ~/program/norme-checker.py'
alias lognorminator='perl ~/program/norminator.perl --auth'

# ╔════════════════╗
# ║     SPEED      ║
# ╚════════════════╝

alias cplibft='cp -r ~/1_Semestre/algorithmie-I/libft ./libft'
alias correction='correction'
alias src='vi ~/\#_my_config/.zshrc;cd -'
alias github='open ~/program/GitHub.app'
alias rb='~/program/ruby-2.1.0/bin/ruby'

# ╔════════════════╗
# ║       VI       ║
# ╚════════════════╝

alias vi='vicd'
alias vo='vicd'
alias ci='vicd'

# ╔════════════════╗
# ║      MAKE      ║
# ╚════════════════╝

alias creatmake='sh ~/program/MakeMakefile.zsh'
alias refreshmake='sh ~/program/MakeMakefile.zsh'

# ╔════════════════╗
# ║     CHMOD      ║
# ╚════════════════╝

alias red='chmod 777 '
alias white='chmod 644 '
alias chdir='chmod 777 '

# ╔════════════════╗
# ║   LOCKSCREEN   ║
# ╚════════════════╝

alias lockscreen='mylockscreen'
alias eat='lockscreen "Je suis parti Manger"'
alias dodo='lockscreen "Je vous emmerde et je rentre a ma maison"'
alias coffee='lockscreen "Pause Coffee pour tenir toute la nuit"'
alias pipi='lockscreen "PIPI / CACA / DOUCHE (ou pas)"'

# ╔════════════════╗
# ║   LOCKSCREEN   ║
# ╚════════════════╝

alias bitnami='open ~/Mamp/manager-osx.app'
alias refresh='bitnami'

# ╔════════════════╗
# ║   CURENT TAFF  ║
# ╚════════════════╝

alias sql='~/mamp/mysql/bin/mysql -uroot -pyeueteyeieoeuei'
alias sqlf='sqlf_file'
