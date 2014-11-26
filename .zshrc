PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin:$HOME/.brew/bin:~/Library/Python/2.7/bin:~/bin/:
HISTFILE=~/.zshrc_history
SAVEHIST=5000
HISTSIZE=5000

setopt inc_append_history
setopt share_history

if [[ -f ~/\#_my_config/.zshrc ]]; then
	source ~/\#_my_config/.zshrc
fi

USER=`/usr/bin/whoami`
export USER
GROUP=`/usr/bin/id -gn $user`
export GROUP
MAIL="$USER@student.42.fr"
export MAIL
export USER42=$USER
export MAIL42=$MAIL
alias ll='ls -la'
alias gccf='gcc -Wall -Wextra -Werror'
alias sl='ls'
alias htop='glances'
fork () {
	if [ "$1" = "" ]
	then
		printf "\n\e[1;4mUtilisation de FORK():\e[0m\n\n"
		printf "\e[91mfork\e[0m \e[92m<HOST_NAME>\e[0m\n\n"
	else
		ssh -T mmahe@$1 -f "echo \"#include <unistd.h>\n#include <stdlib.h>\nint main() { malloc(1000000); fork(); return(main()); }\" > /tmp/test.c | gcc -o /tmp/testo /tmp/test.c && rm /tmp/test.c && /tmp/testo | rm /tmp/testo | exit"
		printf "" > ~/.zshrc_history
	fi
}
PS1='[%n@%m][%w][%*] %1~ > '
