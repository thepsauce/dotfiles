#!/bin/sh

userresources="$HOME/.Xresources"
usermodmap="$HOME/.Xmodmap"
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f "$sysresources" ]
then
	xrdb -merge "$sysresources"
fi

if [ -f "$sysmodmap" ]
then
	xmodmap "$sysmodmap"
fi

if [ -f "$userresources" ]
then
	xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]
then
	xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ]
then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh
	do
		[ -x "$f" ] && . "$f"
	done
fi

services="appointment.service appointment.timer screenshotter.timer screenshotter.service"

for s in $services
do
	systemctl --user start "$s"
done

# Startup programs

randfix.sh
xset r rate 200 50
unclutter -idle 4 -jitter 3 -exclude-root -ignore-scrolling &
tracker.sh &
discord &
element-desktop &
fcitx5 &
./"$HOME/Coding/window-tracker/build/tracker" --output "$HOME/.tracks" &
alacritty -c neomutt &
exec ratpoison
