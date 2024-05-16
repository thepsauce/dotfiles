#!/bin/bash

audio_device=alsa_output.usb-Razer_Razer_Kraken_Tournament_Edition_000000000000000000000000-00.stereo-game.monitor

everything=false
image=false

path="$HOME"

while [ $# -ne 0 ]
do
	case "$1" in
	-a) everything=true ;;
	-i) image=true ;;
	-r) path="$path/$2" ; shift ;;
	-p) path="$2" ; shift ;;
	*) exit 1 ;;
	esac
	shift
done

date=$(date +%Y-%m-%d_%H:%M:%S)

if $everything
then
	display_size=$(xdpyinfo | awk '/dimensions:/ {print $2}')
	X=0
	Y=0
	W=$(echo $display_size | cut -d 'x' -f 1)
	H=$(echo $display_size | cut -d 'x' -f 2)
else
	slop=$(slop -f "%x %y %w %h") || exit 1
	read -r X Y W H <<< $slop
fi

if $image
then
	ffmpeg -f x11grab -draw_mouse 0 -s "$W"x"$H" -i :0.0+$X,$Y -vframes 1 "$path/screenshot-$date.png"
else
	ffmpeg -s "$W"x"$H" -framerate 25 -f x11grab -i :0.0+$X,$Y -f pulse -i $audio_device -c:v libx264 -preset ultrafast -c:a aac -filter:a "volume=4.2" "$path/video-$date.mp4"
fi
