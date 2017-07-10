# This is the config I use for Powerlevel9k

# Custom dir command
function my_dir(){
	homeIcon=" "
	wpPluginsIcon="  "
	wpThemesIcon=""
	# Gets the path.
	local current_path="$(print -P "%~")"

	# Replace either ~ or ~/ with  
	current_path=$(echo $current_path | sed -r -e "s/\~?/$homeIcon/")

	# Replace wp-content/themes with .. if in theme
	current_path=$(echo $current_path | sed -r -e "s/wp\-content\/themes\//\.\.\//") 

	echo $current_path $wpPluginsIcon

}
POWERLEVEL9K_CUSTOM_DIR="my_dir"
POWERLEVEL9K_CUSTOM_DIR_BACKGROUND="blue"
POWERLEVEL9K_CUSTOM_DIR_FOREGROUND="white"


# Left Prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_dir rbenv vcs)

# Right Prompt
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator time)
