#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
cd $SCRIPT_DIR

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
	)

	for i in ${tostow[*]}; do
		stow $i
	done
}

pacmanInstall(){
	local packages=(
		"gvim"
		"zsh"
		"git"
	)
	if pacman -Qs $package > /dev/null; then

	fi
}
