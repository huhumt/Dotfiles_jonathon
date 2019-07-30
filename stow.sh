#!/usr/bin/env sh

tostow=(
	"bin"
	"browserOverides"
	"dunst"
	"git"
	"pandoc"
	"qutebrowser"
	"ranger"
	"rofi"
	"sxiv"
	"vim"
	"zathura"
)

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
cd SCRIPT_DIR

for i in ${tostow[*]}; do
	stow $i
done

