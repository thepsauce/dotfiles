#!/bin/bash

set -Eeo pipefail

if [ -z "$DISPLAY" ] ; then
	echo "\$DISPLAY unset"
	exit 1
fi

audio_device=alsa_output.usb-Razer_Razer_Kraken_Tournament_Edition_000000000000000000000000-00.stereo-game.monitor

force=false

everything=false
image=false

out="$HOME"

usage() {
	echo "Make screenshots and recordings using ffmpeg in X11"
	echo "usage: $0 -[aifh] -[or] <path>"
	echo "  -a|--all      Select everything"
	echo "  -i|--image    Make a screenshot (single frame)"
	echo "  -r|--relative Specify a destination file/folder relative to '$out'"
	echo "  -o|--output   Specify a destination file/folder"
	echo "  -f|--force    Overwrite existing files"
	echo "  -h|--help     Show this help"
	echo "examples:"
	echo "1: Make a screenshot of everything and store it to temp and the clipboard"
	echo "2: Make a recording (slop will ask for an area)"
	echo
	echo "1. $0 -a -i -o \"\$(mktemp).png\""
	echo "2. $0"
}

while [ $# -ne 0 ] ; do
	case "$1" in
	-a|--all) everything=true ;;
	-i|--image) image=true ;;
	-r|--relative) out="$out/$2" ; shift ;;
	-h|--help) usage ; exit 0 ;;
	-o|--output) out="$2" ; shift ;;
	-f|--force) force=true ;;
	*) usage ; exit 1 ;;
	esac
	shift
done

if [ -d "$out" ] ; then
	date="$(date +%Y-%m-%d_%H:%M:%S)"
	if $image ; then
		name="screenshot-$date.png"
	else
		name="video-$date.mp4"
	fi
	out="$(realpath "$out")/$name"
fi

out_dir="$(dirname "$out")"

if ! $force ; then
	if [ -f "$out" ] ; then
		read -p "do you want to overwrite '$out'? [yn]" -n 1 choice
		echo
	elif [ ! -d "$out_dir" ] ; then
		read -p "do you want to create directory '$out_dir'? [yn]" -n 1 choice
		echo
	else
		choice="y"
	fi
	[ "$choice" = "y" ] || exit 0
fi

mkdir -p "$out_dir"

if $everything ; then
	display_size="$(xdpyinfo | awk '/dimensions:/ {print $2}')"
	X=0
	Y=0
	W=$(echo "$display_size" | cut -d 'x' -f 1)
	H=$(echo "$display_size" | cut -d 'x' -f 2)
else
	slop="$(slop -f "%x %y %w %h")"
	read -r X Y W H <<< "$slop"
fi

if $image ; then
	ffmpeg -y -f x11grab -draw_mouse 0 -s "$W"x"$H" -i :0.0+"$X","$Y" -vframes 1 "$out" 2>/dev/null
else
	ffmpeg -y -s "$W"x"$H" -framerate 25 -f x11grab -i :0.0+"$X","$Y" -f pulse -i "$audio_device" -c:v libx264 -preset ultrafast -c:a aac -filter:a "volume=4.2" "$out" 2>/dev/null
fi

printf 'file://%s\r\n' "$out" | xclip -selection clipboard -t text/uri-list
