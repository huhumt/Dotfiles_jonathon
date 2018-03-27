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

function cdlc() {
	cd "$@"
	/home/jonathan/.gem/ruby/2.4.0/bin/colorls --sd | tail -n +2
}
#alias cd="cdlc"

function mkcd() {
	mkdir -p "$1"
	cd "$1"
}

function createLetter(){
	if [ "$1" ]; then
		if [ "$2" ]; then
			newFile="$2"
		else
			newFile="$1"
			newFile="${newFile%.*}.pdf"
		fi
		pandoc --template template-letter.tex $1 -o $newFile
	else
		echo "Oops. You need to suply a file"
		return 1
	fi
}

#Takes you to the parent theme
function ptheme() {
	public_html=${PWD%/public_html*}/public_html
	if [ -d $public_html ]; then
		if [ -d $public_html/wp ]; then
			wpPath=$public_html/wp;
		else
			wpPath=$public_html;
		fi
		theme=$(dirname $(wp --path="$wpPath" theme path $(wp --path="$wpPath" theme list | grep "parent" | awk '{print $1}')))
		if [ -d $theme ]; then
			if [ -d "$theme" ]; then
				cd $theme
			else 
				echo " Can't find theme folder "
			fi
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
		if [ -d $public_html/wp ]; then
			wpPath=$public_html/wp;
		else
			wpPath=$public_html;
		fi
		theme=$(dirname $(wp --path="$wpPath" theme path $(wp --path="$wpPath" theme list | grep "active" | grep -v "inactive" | awk '{print $1}')))
		if [ -d $theme ]; then
			cd $theme
		else
			echo " Can't find theme folder "
		fi
	else
		echo " Can't find public_html folder."
	fi
}

#Takes you to the js folder child theme
function js() {
	public_html=${PWD%/public_html*}/public_html
	if [ -d $public_html ]; then
		if [ -d $public_html/wp ]; then
			wpPath=$public_html/wp;
		else
			wpPath=$public_html;
		fi
		theme=$(dirname $(wp --path="$wpPath" theme path $(wp --path="$wpPath" theme list | grep "active" | grep -v "inactive" | awk '{print $1}')))
		if [ -d $theme ]; then
			if [ -d "$theme/js" ]; then
				cd "$theme/js"
			else
				echo "Can't find a JS folder. Here is the theme"
				cd "$theme"
			fi
		else
			echo " Can't find theme folder "
		fi
	else
		echo " Can't find public_html folder."
	fi
}

#Takes you to the css folder child theme
function css() {
	public_html=${PWD%/public_html*}/public_html
	if [ -d $public_html ]; then
		if [ -d $public_html/wp ]; then
			wpPath=$public_html/wp;
		else
			wpPath=$public_html;
		fi
		theme=$(dirname $(wp --path="$wpPath" theme path $(wp --path="$wpPath" theme list | grep "active" | grep -v "inactive" | awk '{print $1}')))
		if [ -d $theme ]; then
			if [ -d "$theme/css" ]; then
				cd "$theme/css"
			else
				echo "Can't find a CSS folder. Here is the theme"
				cd "$theme"
			fi
		else
			echo " Can't find theme folder "
		fi
	else
		echo " Can't find public_html folder."
	fi
}

#Takes you to the plugin directory
function plugins() {
	public_html=${PWD%/public_html*}/public_html
	if [ -d $public_html ]; then
		if [ -d $public_html/wp ]; then
			wpPath=$public_html/wp;
		else
			wpPath=$public_html;
		fi
		cd $(wp --path="$wpPath" plugin path)
	else
		echo " Can't find public_html folder."
	fi
}

#Takes you to the theme directory
function themes() {
	public_html=${PWD%/public_html*}/public_html
	if [ -d $public_html ]; then
		if [ -d $public_html/wp ]; then
			wpPath=$public_html/wp;
		else
			wpPath=$public_html;
		fi
		cd $(wp --path="$wpPath" theme path)
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
	grep -r -i -n --color="always" --include=\*.{php,phtml} "$1" .
}
searchhtml() {
	grep -r -i -n --color="always" --include=\*.{html,htm} "$1" .
}

png() {
    pngcrush -brute "$1"{,.} && du -b "$1"{,.}
}
gif() {
    gifsicle -O "$1" -o "$1." && du -b "$1"{,.}
}
jpeg() {
    jpegtran "$1" > "$1." && du -b "$1"{,.}
}
# Just for easy access in history
mpng() {
    mv "$1"{.,}
}
mgif() {
    newsize=$(wc -c <"$1.")
    oldsize=$(wc -c <"$1")
    if [ $oldsize -gt $newsize ] ; then
        mv "$1"{.,}
    else
        rm "$1."
    fi  
}
mjpeg() {
    mv "$1"{.,}
}
