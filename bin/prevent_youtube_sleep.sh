#!/bin/bash

window=$(xdotool getactivewindow getwindowname)

case "$window" in
	*"YouTube"*)
		if pulsemixer --list | grep -q "Name: qutebrowser"
		then
			xset s off
		else
			xset s on
		fi
		;;
	*)
		xset s on
		;;
esac
