# This is the config I use for Powerlevel9k

# Custom dir command
function my_dir(){
	homeIcon=" "
	wpPluginsIcon="  "
	wpThemesIcon=""
	siteIcon=" "
	# Gets the path.
	local current_path="$(print -P "%~")"

	# Replace either ~ or ~/ with  
	current_path=$(echo $current_path | sed -r -e "s/\~?/$homeIcon/")

	# Replace wp-content/themes with theme icon if in theme
	current_path=$(echo $current_path | sed -r -e "s/wp\-content\/themes/$wpThemesIcon/")

	# Replace wp-content/plugins with plugin icon if in plugin
	current_path=$(echo $current_path | sed -r -e "s/wp\-content\/plugins/$wpPluginsIcon/")

	#If in a site folder, replace home/Sites/<site-name>/public_html with siteIcon <site-name>
	current_path=$(echo $current_path | sed -r -e "s/$homeIcon\/Sites\/([a-z_\-]*)\/public_html/$siteIcon\1/")
	
	echo $current_path

}
POWERLEVEL9K_CUSTOM_DIR="my_dir"
POWERLEVEL9K_CUSTOM_DIR_BACKGROUND="blue"
POWERLEVEL9K_CUSTOM_DIR_FOREGROUND="white"


# Left Prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_dir rbenv vcs)

# Right Prompt
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator time)
