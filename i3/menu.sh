#!/bin/bash

result=$(echo -e "Anki\nCalendar\nDiscord\nFirefox\nFontforge\nMusescore\nKrita\nQutebrowser\nVlc\nTerminal\nThunderbird" | dmenu -i -l 20 -p Launch -nb "#000016" -nf "#857810" -sf "#ecd200" -sb "#363a59")

case "$result" in
	Anki)
		/usr/bin/anki &
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
	Musescore)
		/usr/bin/mscore &
		;;
	Krita)
		/usr/bin/krita &
		;;
	Qutebrowser)
		/usr/bin/qutebrowser &
		;;
	Vlc)
		/usr/bin/vlc &
		;;
	Thunderbird)
		/usr/bin/thunderbird &
		;;
	Terminal)
		/usr/bin/alacritty &
		;;
esac
