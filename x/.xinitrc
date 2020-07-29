# Make keyboard layout coleemak but pushing both shifts will toggle to qwerty
# setxkbmap -layout gb,gb -variant "colemak," -option grp:shifts_toggle
# Make key firing much faster
# Need this for making qt applications use gtk theme ( I think )
export QT_QPA_PLATFORMTHEME=qt5ct
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Djdk.gtk.version=3 -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export _JAVA_AWT_WM_NONREPARENTING=1
# Use gnome keyring
killall gnome-keyring-d 2> /dev/null
export `gnome-keyring-daemon -d`
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
dbus-update-activation-environment --systemd DISPLAY

export CORPUSER="jonathan.hodgson"
export CORPPASSCOMMAND="pass IRM/corp"

setxkbmap -layout gb,gb -variant "colemak," -option grp:shifts_toggle
xset r rate 200 70
xinput --list | grep -E 'ErgoDox EZ ErgoDox EZ\s+id' | grep -oE 'id=[0-9]+' | cut -d'=' -f2 | xargs -r setxkbmap -layout gb -device

exec /usr/bin/compton --config "$HOME/.config/picom/picom.conf" &
#setbackground &
#/usr/bin/nitrogen --restore &
/usr/bin/systemctl --user start background.service
/usr/lib/kdeconnectd &
/usr/bin/pactl load-module module-switch-on-connect &
/usr/bin/unclutter &
#greenclip daemon &
#exec xrdb .Xresources
#xbindkeys
#exec i3 -V >> ~/i3log-$(date + '%F-%k-%M-%S') 2>&1
#startxfce4
while :; do
	dwm
done;
#exec sh /home/jonathan/.conky/conky-startup.sh
#xcape
