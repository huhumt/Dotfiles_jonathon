# Make keyboard layout coleemak but pushing both shifts will toggle to qwerty
# setxkbmap -layout gb,gb -variant "colemak," -option grp:shifts_toggle
# Make key firing much faster
# Need this for making qt applications use gtk theme ( I think )
export QT_QPA_PLATFORMTHEME=qt5ct
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Djdk.gtk.version=3 -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export _JAVA_AWT_WM_NONREPARENTING=1
if type -p gnome-keyring-daemon > /dev/null; then
	# Use gnome keyring
	killall gnome-keyring-d 2> /dev/null
	export `gnome-keyring-daemon -d`
	eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
	export $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
fi
dbus-update-activation-environment --systemd DISPLAY

export CORPUSER="jonathan.hodgson"
export CORPPASSCOMMAND="pass IRM/corp"

#setxkbmap -layout gb,gb -variant "colemak," -option grp:shifts_toggle
#xset r rate 200 70

# Set keymap to colemak
setxkbmap -layout gb,gb -variant "colemak," -option grp:shifts_toggle

# Set key rate
xset r rate 200 70;

# Unset my ergodox as it is already colemak
xinput --list | grep -Ei 'ErgoDox EZ\s+id' | grep -oE 'id=[0-9]+' |
	cut -d'=' -f2 | xargs -r setxkbmap -layout gb -device
#
type -p compton > /dev/null && exec /usr/bin/compton --config "$HOME/.config/picom/picom.conf" &
#setbackground &
#/usr/bin/nitrogen --restore &
/usr/bin/systemctl --user start background.service
[ -f /usr/lib/kdeconnectd ] && /usr/lib/kdeconnectd &
[ -f /usr/bin/pactl ] && /usr/bin/pactl load-module module-switch-on-connect &
[ -f /usr/bin/unclutter ] && /usr/bin/unclutter &

type -p lisgd 2> /dev/null && lisgd &

if hostname | grep -q phone; then
	xrandr --output DSI-1 --mode 720x1440 --dpi 192
fi

#greenclip daemon &
#exec xrdb .Xresources
#xbindkeys
#exec i3 -V >> ~/i3log-$(date + '%F-%k-%M-%S') 2>&1
#startxfce4
#while :; do
	dwm
#done;
#exec sh /home/jonathan/.conky/conky-startup.sh
#xcape
