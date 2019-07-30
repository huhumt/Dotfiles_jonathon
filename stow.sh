#!/usr/bin/env sh

tostow=( 
	"vim"
	"bin"
	"ranger"
	"qutebrowser"
	"zathura"
	"sxiv"
	"rofi"
	"dunst"
)

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
cd SCRIPT_DIR

for i in ${tostow[*]}; do
	stow $i
done

