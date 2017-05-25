export QT_QPA_PLATFORMTHEME=qt5ct
export `gnome-keyring-daemon -d`
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
dbus-update-activation-environment --systemd DISPLAY
#exec xrdb .Xresources
exec i3 -V >> ~/i3log-$(date + '%F-%k-%M-%S') 2>&1
exec sh /home/jonathan/.conky/conky-startup.sh
