#!/bin/bash

result=$(echo -e "Anki\nAseprite\nCalendar\nDiscord\nFirefox\nFontforge\nInternet\nMusescore\nKICad\nKrita\nPeriodic table\nRemind\nTerminal\nThunderbird\nVlc\nYoutube Music" | dmenu -i -l 20 -p Launch -nb "#000016" -nf "#857810" -sf "#ecd200" -sb "#363a59")

case "$result" in
	Anki)
		/usr/bin/anki &
		;;
	Aseprite)
		/usr/bin/aseprite &
		;;
	Calendar)
		~/.config/i3status/calendar.sh &
		;;
	Discord)
		/usr/bin/discord &
		;;
	Firefox)
		/usr/bin/firefox &
		;;
	Fontforge)
		/usr/bin/fontforge &
		;;
	Internet)
		/usr/bin/qutebrowser &
		;;
	Musescore)
		/usr/bin/mscore &
		;;
	KICad)
		/usr/bin/kicad &
		;;
	Krita)
		/usr/bin/krita &
		;;
	"Periodic table")
		/usr/bin/kalzium &
		;;
	Remind)
		urxvt -name popup -e vim ~/.reminders/appointments.rem &
		;;
	Thunderbird)
		/usr/bin/thunderbird &
		;;
	Terminal)
		/usr/bin/alacritty &
		;;
	Vlc)
		/usr/bin/vlc &
		;;
	"Youtube Music")
		/usr/bin/youtube-music &
		;;
esac
