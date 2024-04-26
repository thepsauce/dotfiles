#!/bin/bash

WINID=$(xdotool search --classname TogglingTerminal)

NUM=wc -w <<< $WINID

if [ $NUM -gt 1 ]
then
	FIRST=true
	for id in $WINID
	do
		if $FIRST
		then
			FIRST=false
			continue
		fi
		xdotool windowkill $id
	done
fi

if [ -z $WINID ]
then
	alacritty --class Alacritty,TogglingTerminal -e screen &

	while [ -z "$WINID" ]
	do
		WINID=$(xdotool search --classname TogglingTerminal)
		sleep 0.1
	done

	exit
fi

xwininfo -id $WINID | grep -q "Map State: IsUnMapped"
if [ "$?" = "0" ]
then
	xdotool windowmap $WINID
else
	xdotool windowunmap $WINID
fi
