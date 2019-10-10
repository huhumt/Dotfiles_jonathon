#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
cd $SCRIPT_DIR

#Atts a slash if there isn't one at the end
slashIt(){
	local str=$1
	case "$str" in
		*/)
			echo "$str"
			;;
		*)
			echo "$str/"
			;;
	esac
}

doStow(){
	local tostow=(
		"bin"
		"browserOverides"
		"dunst"
		"git"
		"pandoc"
		"qutebrowser"
		"ranger"
		"rofi"
		"sxiv"
		"templates"
		"vim"
		"x"
		"zathura"
		"shells/zsh"
	)

	for i in ${tostow[*]}; do
		if [ -d "$SCRIPT_DIR/$i/STOW" ]; then
			cd "$SCRIPT_DIR/$i"
			stow -t $HOME STOW
		else
			cd $(dirname $i)
			stow -t $HOME $(basename $i)
		fi
		cd $SCRIPT_DIR
	done
}

pacmanInstall(){
	local packages=(
		"arandr"
		"bat"
		"blueberry"
		"dunst"
		"gimp"
		"gimp-plugin-resynthensizer-git"
		"gimp-plugin-saveforweb"
		"git"
		"gvim"
		"imagemagick"
		"imagemagick-doc"
		"inkscape"
		"libreoffice-fresh"
		"libreoffice-fresh-en-gb"
		"pandoc"
		"qutebrowser"
		"ripgrep"
		"stow"
		"w3m"
		"zathura"
		"zathura-pdf-mupdf"
		"zsh"
	)
	for package in ${packages[*]}; do
		if pacman -Qs $package > /dev/null; then
			echo "Installing $package"
			sudo pacman -S $package
		else
			echo "Already installed $package"
		fi
	done
}

aurInstall(){
	local packages=(
		"mps-youtube-git"
		"ddgr"
	)
	if yay -Qs $package > /dev/null; then
		echo "Installing $i"
		sudo yay -S $i
	fi
}

dwmInstall(){
	cd NOSTOW/dwm/
	if [ -i config.h ]; then
		sudo rm config.h
	fi
	sudo make install
	cd $SCRIPT_DIR
}

stInstall(){
	cd NOSTOW/st/
	if [ -i config.h ]; then
		sudo rm config.h
	fi
	sudo make install
	cd $SCRIPT_DIR
}

#dwmInstall
#stInstall
#pacmanInstall
doStow

