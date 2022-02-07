#!/bin/sh
pkill compton
laptopScreen="eDP-1"
laptopResolution="$(xrandr | grep -A 1 "$laptopScreen" | sed -n 2p | awk '{print $1}')"
xrandr | sed '/^ /d' | grep -Ev '(:|eDP-1)' | awk -v ORS=" " '{print "--output " $1 " --off"}' |
	xargs xrandr --output "$laptopScreen" --primary --mode "$laptopResolution" --pos 0x0 --rotate normal
/usr/bin/compton --config "$HOME/.config/picom/picom.conf" & disown
