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
	"templates"
	"vim"
	"x"
	"zathura"
)

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
cd SCRIPT_DIR

for i in ${tostow[*]}; do
	stow $i
done

