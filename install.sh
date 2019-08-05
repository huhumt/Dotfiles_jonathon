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
		"gvim"
		"zsh"
		"git"
		"pandoc"
		"stow"
	)
	if pacman -Qs $package > /dev/null; then
		echo "Install $i"
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

dwmInstall
stInstall
pacmanInstall
doStow

