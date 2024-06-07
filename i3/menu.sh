#!/bin/bash

entries=(
	"Anki,/usr/bin/anki"
	"Aseprite,/usr/bin/aseprite"
	"Calendar,$HOME/.config/i3status/calendar.sh"
	"Discord,/usr/bin/discord"
	"Fontforge,/usr/bin/fontforge"
	"Internet,/usr/bin/firefox"
	"Musescore,/usr/bin/mscore"
	"KICad,/usr/bin/kicad"
	"Krita,/usr/bin/krita"
	"Periodic table,/usr/bin/kalzium"
	"Remind,/usr/bin/alacritty --class Alacritty,popup -e vim $HOME/.reminders/appointments.rem"
	"Steam,/usr/bin/steam -debug_steamapi -console"
	"Terminal,/usr/bin/alacritty"
	"Thunderbird,/usr/bin/thunderbird"
	"VirtualBox,/usr/bin/virtualbox"
	"Vlc,/usr/bin/vlc"
	"Write Stylus,/usr/bin/write_stylus"
	"Youtube Music,/usr/bin/youtube-music"
)

IFS=$'\n' sorted=($(sort <<<"${entries[*]}"))

items=

for i in "${!entries[@]}"
do
	e="${entries[$i]}"
	if [ $i -gt 0 ]
	then
		items="$items"'\n'
	fi
	items="$items${e%%,*}"
done

result=$(echo -e "$items" | dmenu -fn Pixy -i -l 20 -p Launch -nb "#000016" -nf "#857810" -sf "#ecd200" -sb "#363a59")

for e in "${entries[@]}"
do
	if [ "$result" = "${e%%,*}" ]
	then
		eval ${e#*,}
		break
	fi
done

