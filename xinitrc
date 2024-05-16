#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]
then
	xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]
then
	xmodmap $sysmodmap
fi

if [ -f "$userresources" ]
then
	xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]
then
	xmodmap "$usermodmap"
fi

# start some nice programs

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
	systemctl --user start $s
done

xrandr --output DVI-D-0 --left-of HDMI-A-0
xrandr --output HDMI-A-0 --primary
xset r rate 200 50
unclutter -idle 4 &
/usr/local/bin/tracker.sh &
exec i3
