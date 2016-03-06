autoload -U colors && colors

TMOUT=1
TRAPALRM() {
   if [[ ${commands[(r)$LBUFFER]} == $LBUFFER ]] ; then
       zle reset-prompt
   fi
}

reset="%{$reset_color%}"

fg_color=$'%{\e[38;5;015m%}'

home_bg=$reset
home_fg=$reset

home_bg_color=$'%{\e[48;5;25m%}'
home_fg_color=$'%{\e[38;5;25m%}'
home_bg_color2=$'%{\e[48;5;32m%}'
home_fg_color2=$'%{\e[38;5;32m%}'

dir_bg=$reset
dir_fg=$reset

dir_bg_color=$'%{\e[48;5;237m%}'
dir_fg_color=$'%{\e[38;5;237m%}'
dir_bg_color2=$'%{\e[48;5;239m%}'
dir_fg_color2=$'%{\e[38;5;239m%}'

root_bg=$reset
root_fg=$reset

root_bg_color=$'%{\e[48;5;91m%}'
root_fg_color=$'%{\e[38;5;91m%}'
root_bg_color2=$'%{\e[48;5;93m%}'
root_fg_color2=$'%{\e[38;5;93m%}'

red_bg=$'%{\e[48;5;124m%}'
red_fg=$'%{\e[38;5;124m%}'

git_bg=$reset
git_fg=$reset

git_bg_color=$'%{\e[48;5;037m%}'
git_fg_color=$'%{\e[38;5;037m%}'
git_bg_color2=$'%{\e[48;5;006m%}'
git_fg_color2=$'%{\e[38;5;006m%}'
not_git_bg_color=$'%{\e[48;5;242m%}'
not_git_fg_color=$'%{\e[38;5;242m%}'

battery_fg_color=$'%{\033[38;5;208m%}'
battery_bg_color=$'%{\033[48;5;208m%}'
battery_fg_color2=$'%{\033[38;5;214m%}'
battery_bg_color2=$'%{\033[48;5;214m%}'


time_fg_color=$'%{\e[38;5;25m%}'
time_bg_color=$'%{\e[48;5;25m%}'
time_fg_color2=$'%{\e[38;5;32m%}'
time_bg_color2=$'%{\e[48;5;32m%}'

host_fg_color=$'%{\e[38;5;28m%}'
host_bg_color=$'%{\e[48;5;28m%}'
host_fg_color2=$'%{\e[38;5;34m%}'
host_bg_color2=$'%{\e[48;5;34m%}'

fgplus0=$'%{\e[38;5;242m%}'
fgplus1=$'%{\e[38;5;245m%}'
fgplus2=$'%{\e[38;5;250m%}'

PR_TITLEBAR=$'%{\e]0;%m %~/\a%}'
PR_STITLE=$'%{\e\e%}'

fg_white=$'%{\e[38;5;231m%}'
# ╔════════════════╗
# ║     PROMPT     ║
# ╚════════════════╝

function precmd()
{
	my_prompt
}

function my_prompt()
{
	local HOME_DIR=`echo $HOME\/`
	local my_pwd
	my_pwd=`echo $PWD | sed 's/\/Volumes\/Data//'`
	if [[ -z ${TOGGLE} ]]; then
		TOGGLE=1
		home_bg=$home_bg_color
		home_fg=$home_fg_color
		dir_bg=$dir_bg_color
		dir_fg=$dir_fg_color
		root_bg=$root_bg_color
		root_fg=$root_fg_color
		git_bg=$git_bg_color
		git_fg=$git_fg_color
		time_fg=$time_fg_color;
		time_bg=$time_bg_color;
		host_fg=$host_fg_color;
		host_bg=$host_bg_color;
		battery_fg=$battery_fg_color;
		battery_bg=$battery_bg_color;
	else
		unset TOGGLE
		home_bg=$home_bg_color2
		home_fg=$home_fg_color2
		dir_bg=$dir_bg_color2
		dir_fg=$dir_fg_color2
		root_bg=$root_bg_color2
		root_fg=$root_fg_color2
		git_bg=$git_bg_color2
		git_fg=$git_fg_color2
		time_fg=$time_fg_color2;
		time_bg=$time_bg_color2;
		host_fg=$host_fg_color2;
		host_bg=$host_bg_color2;
		battery_fg=$battery_fg_color2;
		battery_bg=$battery_bg_color2;
	fi

	if [[ "$my_pwd" == $HOME ]]; then
		prompt_in_home
	elif [[ "$my_pwd" == $HOME_DIR* ]]; then
		prompt_in_home
	else
		prompt_in_not_home
	fi

	___Right_Prompt
}

# ╔════════════════╗ #
# ║  LEFT  PROMPT  ║ #
# ╚════════════════╝ #

function prompt_in_home()
{
	local locallast="$(basename "$PWD")"
	local localhome
	localhome=`echo $PWD | sed 's/\/Volumes\/Data//'`
	localhome=`echo $localhome | sed 's/'"${HOME//\//\\/}"'//'`
	if [[ -n $localhome ]]; then
		localhome=`echo $localhome | sed 's/\(.*\)'${locallast}'/\1/'`
		localhome=`echo ${localhome%?}`
		localhome=`echo ${localhome:1}`
		local tmp=$localhome
		localhome=`echo $localhome | sed 's/\//   /g'`
#		localhome=`echo $localhome | sed 's/\//   /g'`
		___Left_Prompt "~" $localhome $tmp $locallast
	else
		PROMPT="$PR_STITLE${PR_TITLEBAR}${root_bg}${fg_color} ~ ${reset}${root_fg}$(___Check_Permition) ${reset}"
	fi
}

function prompt_in_not_home()
{
	local locallast="$(basename "$PWD")"
	local localhome
	if [ `echo $PWD | wc -c` -gt '2' ]; then
		localhome=`echo $PWD`
		localhome=`echo $localhome | sed 's/\(.*\)'${locallast}'/\1/'`
		localhome=`echo ${localhome%?}`
		localhome=`echo ${localhome:1}`
		local tmp=$localhome
		localhome=`echo $localhome | sed 's/\//   /g'`
#		localhome=`echo $localhome | sed 's/\//   /g'`
		___Left_Prompt "@" $localhome $tmp $locallast
	else
		PROMPT="$PR_STITLE${PR_TITLEBAR}${root_bg}${fg_color} @ ${reset}${root_fg}$(___Check_Permition) ${reset}"
	fi
}

function ___Left_Prompt()
{
	local tmp=$2
	PROMPT="$PR_STITLE${PR_TITLEBAR}${root_bg}${fg_color} $1 "
	if [ `echo $tmp | wc -c` -gt '30' ]; then
		tmp=`echo "${fgplus0}.${fgplus1}.${fgplus2}.${reset}${dir_bg}${fg_color}  $(basename "$3")"`
	fi
	if [[ -n $4 ]]; then
		PROMPT+="${dir_bg}${root_fg}${reset}${dir_bg}${fg_color} $tmp ${reset}"
		PROMPT+="${home_bg}${dir_fg}"
		PROMPT+="${reset}${home_bg}${fg_color} $4 ${reset}${home_fg}$(___Check_Permition) ${reset}"
	else
		PROMPT+="${home_bg}${root_fg}"
		PROMPT+="${reset}${home_bg}${fg_color} $2 ${reset}${home_fg}$(___Check_Permition) ${reset}"
	fi
}

function ___Check_Permition()
{
	permition=`echo ""`
	if [ ! -w $PWD ]; then
		permition=`echo "${red_bg}${fg_color}  ${reset}${red_fg}"`
	fi
	permition+=`echo ""`
	echo $permition
}
# ╔════════════════╗ #
# ║  RIGHT PROMPT  ║ #
# ╚════════════════╝ #

function ___Right_Prompt()
{
#	git_bg=$not_git_bg_color
#	git_fg=$not_git_fg_color

	power_fg=$host_fg
	power_bg=$host_bg
	if [[ 50 > $(battery_charge) &&  $(battery_charge) > 25 ]]; then
		power_fg=$battery_fg
		power_bg=$battery_bg

	fi
	if [[ 26 > $(battery_charge) ]]; then
		power_fg=$red_fg
		power_bg=$red_bg
	fi
	if [[ $(ischarging) == "Yes" ]]; then
		power_fg=$root_fg
		power_bg=$root_bg
	fi
		RPROMPT="${power_fg}${power_bg}${fg_color} ⚡ $(battery_charge)%% ⚡"

	if [[ -n $(___Check_Git_Branch) ]]; then
		if [[ -n $(___Check_Git_Status) ]]; then
			git_bg=$git_bg_color
			git_fg=$git_fg_color
		fi
#		RPROMPT="${not_git_fg_color}${not_git_bg_color}${fg_color} %D{%H:%M:%S} ${git_fg} ${git_bg}${fg_color} $(___Check_Git_Branch)  ${reset}"
		RPROMPT+=" ${git_fg}${git_bg}${fg_color} $(___Check_Git_Branch) "
	#	else
	#		RPROMPT="${host_fg}${host_bg} ${fg_color}%m 💻  ${time_fg}${time_bg}${fg_color} %D{%H:%M:%S} ${reset}"
	fi
	RPROMPT+=" ${time_fg}${time_bg}${fg_color} %D{%H:%M:%S} ${reset}"
}

function ___Check_Git_Branch()
{
	if gittest=`git status --ignore-submodules` &> /dev/null; then
		branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
		echo $branch
	fi
}

function ___Check_Git_Status()
{
	if gittest=`git status --ignore-submodules` &> /dev/null; then
		testgit=`echo "nothing to commit"`
		if [[ "$gittest" == *$testgit* ]]; then

		else
			echo "0"
		fi
	fi
}
function battery_charge()
{
	printf %.0f $(echo $(ioreg -l -n AppleSmartBattery -r | grep CurrentCapacity | awk '{print $3}') \* 100 / $(ioreg -l -n AppleSmartBattery -r | grep MaxCapacity | awk '{print $3}') +1.5 | bc -l);
}
function ischarging()
{
	echo $(ioreg -l -n AppleSmartBattery -r | grep ExternalConnected | awk '{print $3}')
}
