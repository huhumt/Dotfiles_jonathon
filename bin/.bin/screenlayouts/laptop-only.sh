#!/bin/sh
pkill compton
xrandr | sed '/^ /d' | grep -Ev '(:|eDP-1)' | awk -v ORS=" " '{print "--output " $1 " --off"}' |
	xargs xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
/usr/bin/compton --config "$HOME/.config/picom/picom.conf" & disown
