#!/bin/sh

laptopScreen="eDP-1"
externalScreen="$(xrandr | grep -Eo '^.* connected' | grep -v "$laptopScreen" |
	cut -d ' ' -f 1)"
externalResolution="$(xrandr | grep -A 1 "$externalScreen" | sed -n 2p | awk '{print $1}')"

pkill compton
xrandr --output "$laptopScreen" --primary --mode 1920x1080 --pos "${externalResolution%x*}x0" --rotate normal --output "$externalScreen" --mode "$externalResolution" --pos 0x0 --rotate normal
/usr/bin/compton --config "$HOME/.config/picom/picom.conf" & disown
