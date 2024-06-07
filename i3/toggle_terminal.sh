#!/bin/bash

set -o xtrace

WINIDS=$(xdotool search --classname TogglingTerminal)

NUM=$(wc -w <<< $WINIDS)

if [ $NUM -gt 1 ]
then
	FIRST=true
	for id in $WINIDS
	do
		if $FIRST
		then
			FIRST=false
			WINID=$id
			continue
		fi
		xdotool windowkill $id
	done
else
    WINID=$WINIDS
fi

if [ -z $WINID ]
then
	alacritty --class Alacritty,TogglingTerminal &

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
