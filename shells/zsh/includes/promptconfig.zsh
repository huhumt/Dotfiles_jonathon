# This is the config I use for Powerlevel9k

# Custom dir command
function my_dir(){
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

}
POWERLEVEL9K_CUSTOM_DIR="my_dir"
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
	POWERLEVEL9K_CUSTOM_DIR_BACKGROUND="green"
	POWERLEVEL9K_CUSTOM_DIR_FOREGROUND="black"
else
	POWERLEVEL9K_CUSTOM_DIR_BACKGROUND="blue"
	POWERLEVEL9K_CUSTOM_DIR_FOREGROUND="black"
fi

# POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR="\ue0c0"
# POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR="\ue0c2"

function Capslock(){
	x=$(xset -q | grep Caps) 2> /dev/null || exit 0
	x=${x:22:1}
	if [[ $x == "n" ]]; then

		echo ""
	fi
}
POWERLEVEL9K_CUSTOM_CAPS="Capslock"
POWERLEVEL9K_CUSTOM_CAPS_BACKGROUND="red"
POWERLEVEL9K_CUSTOM_CAPS_FOREGROUND="white"


function prompt_project() {
	local segment_content state icon
	local parent_process="$(ps -ocommand -p $PPID | grep -v 'COMMAND' | cut -d' ' -f1)"
	local current_project_full="$(project current --path)"
	local current_project_name="$(project current)"
	if [[ "$parent_process" == "/usr/bin/script" ]]; then
		segment_content="辶"
	fi
	# If there is a current project
	if [ -n "$current_project_name" ]; then
		segment_content="${segment_content}$current_project_name"
		# If in the current project
		if echo "$PWD" | grep -q "$current_project_full"; then
			state="INSIDE"
		elif echo "$PWD" | grep -q "$HOME/Projects/"; then
			state="WRONG"
		else
			state="OUTSIDE"
		fi
	fi

	if [ -n "$segment_content" ]; then
		"$1_prompt_segment" "${0}_${state}" "$2" $DEFAULT_COLOR_INVERTED $DEFAULT_COLOR "$segment_content" "$icon"
	fi
}


POWERLEVEL9K_PROJECT_DEFAULT_FOREGROUND="black"
POWERLEVEL9K_PROJECT_WRONG_BACKGROUND="red"
POWERLEVEL9K_PROJECT_OUTSIDE_BACKGROUND="yellow"
POWERLEVEL9K_PROJECT_INSIDE_BACKGROUND="green"

# Left Prompt
if [[ "$(basename "/"$(ps -f -p $(cat /proc/$(echo $$)/stat | cut -d \  -f 4) | tail -1 | sed 's/^.* //'))" != "$(echo $USER)" ]]; then
	POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(project custom_dir vcs custom_caps)
fi

# Right Prompt
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator)
