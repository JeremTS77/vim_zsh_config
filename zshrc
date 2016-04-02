PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin:$HOME/.brew/bin:~/Library/Python/2.7/bin:~/bin/:$HOME/.rvm/bin

#History
HISTFILE=~/.zshrc_history
SAVEHIST=5000
HISTSIZE=5000
setopt inc_append_history
setopt share_history

#conf homemade
if [[ -f ~/\#_my_config/.zshrc ]]; then
	source ~/\#_my_config/.zshrc
fi

#export
USER=`/usr/bin/whoami`
export USER
GROUP=`/usr/bin/id -gn $user`
export GROUP
export MAIL
export USER42="$USER"
export MAIL42="$USER42@student.42.fr"

#alias
alias gccf='gcc -Wall -Wextra -Werror'
#---
alias ll='ls -l'
alias sl='ls'
alias l='ls -1'
alias la='ls -a'
alias lla='ls -la'
#---

#ocaml
alias ocaml='rlwrap ocaml'

#PS1='[%n@%m][%w][%*] %1~ > '
