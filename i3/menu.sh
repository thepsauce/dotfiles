#!/bin/bash

result=$(echo -e "Anki\nCalendar\nDiscord\nFirefox\nFontforge\nMusescore\nKICad\nKrita\nPeriodic table\nQutebrowser\nRemind\nTerminal\nThunderbird\nVlc" | dmenu -i -l 20 -p Launch -nb "#000016" -nf "#857810" -sf "#ecd200" -sb "#363a59")

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
	KICad)
		/usr/bin/kicad &
		;;
	Krita)
		/usr/bin/krita &
		;;
	"Periodic table")
		/usr/bin/kalzium &
		;;
	Qutebrowser)
		/usr/bin/qutebrowser &
		;;
	Remind)
		urxvt -name popup -e vim ~/.reminders/appointments.rem
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
esac
