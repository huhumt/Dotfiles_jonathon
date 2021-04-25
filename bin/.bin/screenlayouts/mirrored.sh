#!/bin/sh

laptopScreen="eDP-1"
externalScreen="$(xrandr | grep -Eo '^.* connected' | grep -v "$laptopScreen" |
	cut -d ' ' -f 1)"

pkill compton
xrandr --output "$laptopScreen" --primary --mode 1920x1080 --pos 0x0 --rotate normal --output "$externalScreen" --mode 1920x1080 --pos 0x0 --rotate normal
/usr/bin/compton --config "$HOME/.config/picom/picom.conf" & disown
