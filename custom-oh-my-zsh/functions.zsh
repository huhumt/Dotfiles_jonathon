function big-chromium () {
	chromium --force-device-scale-factor=$1
}

function big-new-chromium () {
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
