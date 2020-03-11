# This is the config I use for Powerlevel9k


#source "$HOME/.dotfiles/shells/zsh/plugins/powerlevel9k/powerlevel9k.zsh-theme"


# Custom dir command
prompt_dir(){
	homeIcon=""
	wpPluginsIcon=".p."
	wpThemesIcon=".t."
	siteIcon=" "
	wpSiteIcon=" "
	magentoSiteIcon=" "
	dropboxIcon=""
	seperator="  "
	seperatorDual="  "
	root="$seperator"
	# Gets the path.
	local current_path="$(print -P "%~")"

	# Replace either ~ or ~/ with  
	current_path=$(echo $current_path | sed -r -e "s/\~/$homeIcon/")

	# Replace wp-content/themes with theme icon if in theme
	# current_path=$(echo $current_path | sed -r -e "s/wp\-content\/themes/$wpThemesIcon/")

	# Replace wp-content/plugins with plugin icon if in plugin
	# current_path=$(echo $current_path | sed -r -e "s/wp\-content\/plugins/$wpPluginsIcon/")

	current_project_full="$(project current --path)"
	if [ -n "$current_project_full" ]; then
		if echo "$PWD" | grep -q "$current_project_full"; then
			current_path=$(echo $PWD | sed -r -e "s#$current_project_full##" | sed -r -e 's/^\///')
			current_path="$current_path"
		fi
	fi
	#
	#This is used for checking if wp or magento
	local ph=${PWD%/public_html*}/public_html
	# If in a site folder and a wp site, replace home/Sites/<site-name>/public_html with siteIcon <site-url>
	if [[ -d $ph ]]; then
		local icon=$siteIcon
		if [[ -e "$ph/wp-config.php" ]]; then #If WordPress
			icon=$wpSiteIcon
			
			# Change wp-content in sub folders
			current_path=$(echo $current_path | sed -r -e "s/wp\-content\//wpc\//")
			
			if [[ $(tput cols) -lt 100 ]]; then
				current_path=$(echo $current_path | sed -r -e "s/wpc\/themes\//\//")
				current_path=$(echo $current_path | sed -r -e "s/wpc\/plugins\//\//")
			fi

		elif [[ -e "$ph/bin/magento" ]]; then #If magento
			icon=$magentoSiteIcon
		fi
		current_path=$(echo $current_path | sed -r -e "s/$homeIcon\/Sites\/([a-z_\-]*)\/public_html/$icon\1/")
	fi



	# Replace Dropbox with icon
	current_path=$(echo $current_path | sed -r -e "s/$homeIcon\/Dropbox/$dropboxIcon/")

	# Set the root
	current_path=$(echo $current_path | sed -r -e "s/^\//$root/g")
	
	# Set the dual seperator
	current_path=$(echo $current_path | sed -r -e "s/\/\//$seperatorDual/g")

	# Set the seperator
	current_path=$(echo $current_path | sed -r -e "s/\//$seperator/g")

	# If seperator is at the end, remove it (this should only be the case if in root directory)
	current_path=$(echo $current_path | sed -r -e "s/$seperator\$//g")

	echo $current_path
	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
		echo "green"
	else
		echo "blue"
	fi
	echo "black"

}

function prompt_project() {
	# Prints the current project and a recording symbol if appropriate
	local parent_process="$(ps -ocommand -p $PPID | grep -v 'COMMAND' | cut -d' ' -f1)"
	local current_project_full="$(project current --path)"
	local current_project_name="$(project current)"
	local background=""
	if [[ "$parent_process" == "/usr/bin/script" ]]; then
		segment_content="辶"
	fi
	# If there is a current project
	if [ -n "$current_project_name" ]; then
		segment_content="${segment_content}$current_project_name"
		# If in the current project
		if echo "$PWD" | grep -q "$current_project_full"; then
			background="green"
		elif echo "$PWD" | grep -q "$HOME/Projects/"; then
			background="red"
		else
			background="yellow"
		fi
	fi

	echo "$state$segment_content"
	echo "$background"
	echo "black"
}

prompt_git(){
	local branch="$(git branch --show-current 2> /dev/null)"
	local color="green"
	local ret=""
	if [ -n "branch" ]; then
		ret="$branch"
		local repoTopLevel="$(command git rev-parse --show-toplevel 2> /dev/null)"
		local untrackedFiles=$(command git ls-files --others --exclude-standard "${repoTopLevel}" 2> /dev/null)
		local staged=$(command git diff --staged --name-only 2> /dev/null)

		if [ -n "$untrackedFiles" ]; then
			ret="$ret "
			color="orange1"
		fi
		if [ -n "$staged" ]; then
			ret="$ret "
			color="orange1"
		fi
		
	fi
	echo "$ret"
	echo "$color"
}

prompt_last_exit_code() {
  local LAST_EXIT_CODE="$1"
  if [[ $LAST_EXIT_CODE -ne 0 ]]; then
    local EXIT_CODE_PROMPT=' '
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg_bold[red]%}$LAST_EXIT_CODE%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
    echo "$EXIT_CODE_PROMPT"
  fi
}

# Draws a seperator
# Takes 2 arguments, from color then to color
# If only 1 given, assumes it is the last
seperator(){
	local from="$1"
	local to="$2"
	local sep=""
	if [ -z "$to" ]; then
		resetColor
	else
		focusBackgroundColor "$to"
	fi
	focusForegroundColor "$from"
	echo -n "$sep"
	resetColor
}

draw_segment(){
	# Echoes a segment
	# $1 is the command to be run to print the segment
	# $2 is the color of the last segment (if empty, no seperator is added)
	# Returns segment on line 1
	# returns background color on line 2
	local output="$($1)"
	local contents="$(echo "$output" | sed -n '1p')"
	local previousBackground="$2"
	local background=""
	local foreground=""
	local ret=""
	if [ -n "$contents" ]; then
		background="$(echo "$output" | sed -n '2p')"
		foreground="$(echo "$output" | sed -n '3p')"
		if [ -n "$previousBackground" ]; then
			ret=" $(seperator $previousBackground $background)"
		fi
		ret="$ret$(focusBackgroundColor $background) $(focusForegroundColor $foreground)$contents"
		echo "$ret"
		echo "$background"
	fi
}
set_prompts(){
	# Get the return status of the previous command
	local RETVAL=$?

	#Set background to nothing at the start of the prompt
	local background=""
	local foreground=""

	#Set the prompt to an empty string
	PROMPT=""

	###### Each segment printed here
	
	# Project
	segment="$(draw_segment "prompt_project" "$background")"
	if [ -n "$(echo "$segment" | sed -n '1p')" ];then
		PROMPT="$PROMPT$(echo "$segment" | sed -n '1p')"
		background="$(echo "$segment" | sed -n '2p')"
	fi

	# Directory
	segment="$(draw_segment "prompt_dir" "$background")"
	if [ -n "$(echo "$segment" | sed -n '1p')" ];then
		PROMPT="$PROMPT$(echo "$segment" | sed -n '1p')"
		background="$(echo "$segment" | sed -n '2p')"
	fi

	# Git
	segment="$(draw_segment "prompt_git" "$background")"
	if [ -n "$(echo "$segment" | sed -n '1p')" ];then
		PROMPT="$PROMPT$(echo "$segment" | sed -n '1p')"
		background="$(echo "$segment" | sed -n '2p')"
	fi
	
	PROMPT="$PROMPT $(seperator "$background")$(resetColor)"

#$(resetColor)
	RPROMPT="$(resetColor)$(prompt_last_exit_code "$RETVAL")$(resetColor)"
}
zle -N set_prompts
autoload -U add-zsh-hook
add-zsh-hook precmd set_prompts

