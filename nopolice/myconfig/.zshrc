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
export PATH=$PATH:~/bin
unsetopt beep

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
function rmfast()
{
	if [ -d $* ]; then
		rm -fr $* && ls -a -G
	else
		rm -i $* && ls -a -G
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
# ║     NORME      ║
# ╚════════════════╝

alias save_pwd='pwdsave'
alias /='cdsave'

# ╔════════════════╗
# ║     SPEED      ║
# ╚════════════════╝

alias src='vi ~/\#_my_config/.zshrc;cd -'
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

# ╔════════════════╗
# ║   CURENT TAFF  ║
# ╚════════════════╝

