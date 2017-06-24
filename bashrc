#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


big-chromium () {
	chromium --force-device-scale-factor=$1
}

big-new-chromium () {
	chromium-snapshot-bin --force-device-scale-factor=$1
}

#Swap two files
function swap() {
	mv $1 $1._tmp;
	mv $2 $1;
	mv $1._tmp $2;
}

function old() {
	mv "$1" "$1.old"
}

#This prints the current working directory after doing a cd"
cdls(){
	cd "$@"
	ls -F --color=always
}

#Takes you to the aquarius theme
function aquarius() {
	public_html=${PWD%/public_html*}/public_html
	if [ -d $public_html ]; then
		theme=$public_html/wp-content/themes
		if [ -d $theme ]; then
			cdls $theme/aquarius
		else
			echo " Can't find theme folder "
		fi
	else
		echo " Can't find public_html folder."
	fi
}

#Takes you to the child theme
function theme() {
	public_html=${PWD%/public_html*}/public_html
	if [ -d $public_html ]; then
		theme=$public_html/wp-content/themes
		if [ -d $theme ]; then
			child=$(ls -d $theme/*/ | grep -v "$theme\/aquarius" | grep -v "$theme\/twenty*" | grep -v "$theme\/barelycorporate" -m 1)
			cdls $child
		else
			echo " Can't find theme folder "
		fi
	else
		echo " Can't find public_html folder."
	fi
}

########################################
##                                    ##
##         Search Functions           ##
##                                    ##
########################################

#These search functions use grep to search all sub-folders of the current working directory
searchjs() {
	# This will search through .js and .es6 files but won't search minified files
	grep -r -i -n --color="always" --include=\*.{js,es6} --exclude=\*.min.js "$1" .
}
searchcss() {
	# This will search through .css and .less files but won't search minified files
	grep -r -i -n --color="always" --include=\*.{css,less,scss,sass} --exclude=\*.min.css "$1" .
}
searchphp() {
	grep -r -i -n --color="always" --include="*.php" "$1" .
}

# This makes cd use function above
alias cd="cdls"

# These alow me to easily set the file and folder permissions for a wordpress instilation.
alias folder-perms='find . -type d -not -path "./.git/*" -not -path "./.git" -exec chmod 775 {} \;'
alias file-perms='find . -type f -not -path "./.git/*" -not -path "./.git" -exec chmod 664 {} \;'
alias wp-perms='folder-perms; file-perms'

# Make ls add Indicators to file names and colour the output
alias ls='ls -F --color=always'

# Make tree add indicators and color
alias tree='tree -F -C'

#Start cups
alias cups='sudo systemctl start org.cups.cupsd.service'

#Start network manager
alias net='sudo systemctl start NetworkManager.service'

# Alias lampp because I don't want to clog my PATH
alias lampp='/opt/lampp/lampp'
alias glampp='gksudo /opt/lampp/manager-linux-x64.run'
alias php='/opt/lampp/bin/php'
alias php-cgi='/opt/lampp/bin/php-cgi'
alias php-config='/opt/lampp/bin/php-config'

#Always make all directories necesary
alias mkdir='mkdir -p'

# Shortcut for rewriting wp permalinks
alias perms='wp rewrite flush'

#Clear terminal and screenfetch
alias cls='clear; screenfetch'

#An alias for my standard less configuration
#I don't set it to lessc because sometimes I don't use this config and I always forget how to ignore an alias
#alias myless='lessc --clean-css --source-map-basepath=/home/jonathan/Sites/charts/public_html --source-map --autoprefix="last 3 versions, ie >= 9" styles.less styles.min.css'
alias myless='lessc --clean-css --source-map --autoprefix="last 3 versions, ie >= 9" styles.less styles.min.css'

# Git shortcuts
alias status='git status '
alias st='git status'
alias checkout='git checkout'
alias ch='git checkout'
alias push='git push '
alias pull='git pull '
alias bb='git open'

# Always make grep ouput color
alias grep="grep --color=always"

# Shortcuts to sites folder
alias sites="cd ~/Sites"
alias s="cd ~/Sites"

# Shortcuts to documents folder
alias documents="cd ~/Documents/"
alias d="cd ~/Documents/"

# Shortcuts to home folder
alias home="cd ~/"
alias ~="cd ~/"

#Goes up to the public_html folder
alias ph='cd ${PWD%/public_html*}/public_html'

# Quit the terminal using :q (The same as Vi/Vim)
alias :q='exit;'

# Not sure why and how but this makes sudo work with my aliases
alias sudo='sudo '

#Make the cal command default to start on Sunday
alias cal='cal -s'

# update the third party wordpress plugins we are mirroring
alias u3p='update3rdPartyPlugins'

# Edit my bashrc
alias brc='$EDITOR ~/.bashrc'

# Edit my vimrc
alias vrc='$EDITOR ~/.vimrc'

# Go to my .vim folder
alias .v='cd ~/.vim/'
# Go to my dotfiles folder
#if [[ $(hostname) == "jonathansnuc" ]]; then
#	#Please don't judge - This is a reminant from first days of version controlling dotfiles
#	alias df='cd ~/Downloads/laptopConfig/'
#else
	alias df='cd ~/.dotfiles'
#fi

#Make vim start in server mode
alias vim='vim --servername jab2870'

# moon phase
alias moonphase='weather moon'

#Radio Stations
AUDIO=mpv
alias radio2="$AUDIO http://a.files.bbci.co.uk/media/live/manifesto/audio/simulcast/hls/uk/sbr_med/llnw/bbc_radio_two.m3u8"
alias radio4="$AUDIO http://a.files.bbci.co.uk/media/live/manifesto/audio/simulcast/hls/uk/sbr_med/llnw/bbc_radio_fourfm.m3u8"
alias classic="$AUDIO http://icy-e-bab-04-cr.sharp-stream.com/absoluteradio.mp3"
alias absolute="$AUDIO http://network.absoluteradio.co.uk/core/audio/mp3/live.pls?service=vrbb"

alias bs="curl -s http://cbsg.sourceforge.net/cgi-bin/live | grep -Eo '^<li>.*</li>' | sed s,\\</\\\\?li\\>,,g | shuf -n 1 | cowsay"

alias jq="jq -C"

alias debugBuild='node --inspect-brk /usr/bin/grunt build'

#alias xkcd='curl https://xkcd.com/info.0.json 2> /dev/null| \jq ".img" | xargs feh'

#Old ps1
#PS1='[\u@\h \W]\$ '


# bash completion for the `wp` command
_wp_complete() {
	local OLD_IFS="$IFS"
	local cur=${COMP_WORDS[COMP_CWORD]}
	IFS=$'\n';  # want to preserve spaces at the end
	local opts="$(wp cli completions --line="$COMP_LINE" --point="$COMP_POINT")"
	if [[ "$opts" =~ \<file\>\s* ]]
	then
		COMPREPLY=( $(compgen -f -- $cur) )
	elif [[ $opts = "" ]]
	then
		COMPREPLY=( $(compgen -f -- $cur) )
	else
		COMPREPLY=( ${opts[*]} )
	fi
	IFS="$OLD_IFS"
	return 0
}
complete -o nospace -F _wp_complete wp

export GIT_PS1_SHOWDIRTYSTATE=1  # Show the +(Staged) or *(unstaged) next to branch name for
export GIT_PS1_SHOWUNTRACKEDFILES=1  # Show the %(Untracked) next to branch name
export GIT_PS1_SHOWUPSTREAM="auto"

source /usr/share/git/completion/git-completion.bash
source /usr/share/git/completion/git-prompt.sh

source $HOME/.dotfiles/t-completion.sh


############################################
##                                        ##
##         Colours for output             ##
##                                        ##
############################################
#{{{
# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

# Underline
UBlack="\[\033[4;30m\]"       # Black
URed="\[\033[4;31m\]"         # Red
UGreen="\[\033[4;32m\]"       # Green
UYellow="\[\033[4;33m\]"      # Yellow
UBlue="\[\033[4;34m\]"        # Blue
UPurple="\[\033[4;35m\]"      # Purple
UCyan="\[\033[4;36m\]"        # Cyan
UWhite="\[\033[4;37m\]"       # White

# Background
On_Black="\[\033[40m\]"       # Black
On_Red="\[\033[41m\]"         # Red
On_Green="\[\033[42m\]"       # Green
On_Yellow="\[\033[43m\]"      # Yellow
On_Blue="\[\033[44m\]"        # Blue
On_Purple="\[\033[45m\]"      # Purple
On_Cyan="\[\033[46m\]"        # Cyan
On_White="\[\033[47m\]"       # White

# High Intensty
IBlack="\[\033[0;90m\]"       # Black
IRed="\[\033[0;91m\]"         # Red
IGreen="\[\033[0;92m\]"       # Green
IYellow="\[\033[0;93m\]"      # Yellow
IBlue="\[\033[0;94m\]"        # Blue
IPurple="\[\033[0;95m\]"      # Purple
ICyan="\[\033[0;96m\]"        # Cyan
IWhite="\[\033[0;97m\]"       # White

# Bold High Intensty
BIBlack="\[\033[1;90m\]"      # Black
BIRed="\[\033[1;91m\]"        # Red
BIGreen="\[\033[1;92m\]"      # Green
BIYellow="\[\033[1;93m\]"     # Yellow
BIBlue="\[\033[1;94m\]"       # Blue
BIPurple="\[\033[1;95m\]"     # Purple
BICyan="\[\033[1;96m\]"       # Cyan
BIWhite="\[\033[1;97m\]"      # White

# High Intensty backgrounds
On_IBlack="\[\033[0;100m\]"   # Black
On_IRed="\[\033[0;101m\]"     # Red
On_IGreen="\[\033[0;102m\]"   # Green
On_IYellow="\[\033[0;103m\]"  # Yellow
On_IBlue="\[\033[0;104m\]"    # Blue
On_IPurple="\[\033[10;95m\]"  # Purple
On_ICyan="\[\033[0;106m\]"    # Cyan
On_IWhite="\[\033[0;107m\]"   # White
#}}}
# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"
Username="\u"

# Default PS1
# \u@\h [\w]$
export PS1=$Username" "$Yellow$PathShort$Color_Off'$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    echo "'$Green'"$(__git_ps1 " (%s)");\
  else \
    echo "'$Red'"$(__git_ps1 " (%s)");\
  fi)"; \
fi)'$Color_Off'\$ '

# export PS1="\[\033[0;97m\]\u \[\033[0;33m\]\w"'$(git branch &>/dev/null;\
# if [ $? -eq 0 ]; then \
#   echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
#   if [ "$?" -eq "0" ]; then \
#     echo "\[\033[0;32m\]"$(__git_ps1 " (%s)");\
#   else \
#     echo "\[\033[0;91m\]"$(__git_ps1 " (%s)");\
#   fi)"; \
# fi)\[\033[0m\]\$ '
function _update_ps1() {
    export PS1="$(~/.config/powerline-shell/powerline-shell.py $? 2> /dev/null)"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

[ -r "$HOME/.smartcd_config" ] && ( [ -n $BASH_VERSION ] || [ -n $ZSH_VERSION ] ) && source ~/.smartcd_config

#If on work computer, cd into sites

#Add tab completeion to sudo commands
complete -cf sudo

clear
#screenfetch
#set -o vi

# vim: foldmethod=marker
