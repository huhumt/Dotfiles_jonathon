# This is the config I use for Powerlevel9k

# Custom dir command
function my_dir(){
	homeIcon=" "
	wpPluginsIcon=".p."
	wpThemesIcon=".t."
	siteIcon=" "
	wpSiteIcon=" "
	magentoSiteIcon=" "
	dropboxIcon=" "
	seperator="  "
	root=" "
	# Gets the path.
	local current_path="$(print -P "%~")"

	# Replace either ~ or ~/ with  
	current_path=$(echo $current_path | sed -r -e "s/\~/$homeIcon/")

	# Replace wp-content/themes with theme icon if in theme
	# current_path=$(echo $current_path | sed -r -e "s/wp\-content\/themes/$wpThemesIcon/")

	# Replace wp-content/plugins with plugin icon if in plugin
	# current_path=$(echo $current_path | sed -r -e "s/wp\-content\/plugins/$wpPluginsIcon/")

	#This is used for checking if wp or magento
	local ph=${PWD%/public_html*}/public_html
	# If in a site folder and a wp site, replace home/Sites/<site-name>/public_html with siteIcon <site-name>
	if [[ -d $ph ]]; then
		local icon=$siteIcon
		if [[ -e "$ph/wp-config.php" ]]; then #If WordPress
			icon=$wpSiteIcon
			current_path=$(echo $current_path | sed -r -e "s/$homeIcon\/Sites\/([a-z_\-]*)\/public_html/$wpSiteIcon\1/")
			
			# Change wp-content in sub folders
			current_path=$(echo $current_path | sed -r -e "s/wp\-content\//wpc\//")

		elif [[ -d "$ph/pub/opt/magento" ]]; then #If magento
			icon=$magentoSiteIcon
		fi
		current_path=$(echo $current_path | sed -r -e "s/$homeIcon\/Sites\/([a-z_\-]*)\/public_html/$icon\1/")
	fi


	# Replace Dropbox with icon
	current_path=$(echo $current_path | sed -r -e "s/$homeIcon\/Dropbox/$dropboxIcon/")
	

	# Set the root
	current_path=$(echo $current_path | sed -r -e "s/^\//$root/g")
	
	# Set the seperator
	current_path=$(echo $current_path | sed -r -e "s/\//$seperator/g")

	echo $current_path

}
POWERLEVEL9K_CUSTOM_DIR="my_dir"
POWERLEVEL9K_CUSTOM_DIR_BACKGROUND="blue"
POWERLEVEL9K_CUSTOM_DIR_FOREGROUND="white"

# POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR="\ue0c0"
# POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR="\ue0c2"

function Capslock(){
	x=$(xset -q | grep Caps)
	x=${x:22:1}
	if [[ $x == "n" ]]; then

		echo ""
	fi
}
POWERLEVEL9K_CUSTOM_CAPS="Capslock"
POWERLEVEL9K_CUSTOM_CAPS_BACKGROUND="red"
POWERLEVEL9K_CUSTOM_CAPS_FOREGROUND="white"

# Left Prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_dir rbenv vcs custom_caps)

# Right Prompt
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator time)
