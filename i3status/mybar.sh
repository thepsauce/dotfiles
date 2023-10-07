echo '{"version":1,"click_events":true}[[]'

while :
do
	# CPU
	# Get the first line with aggregate of all CPUs
	cpu_now=($(head -n1 /proc/stat))
	# Get all columns but skip the first (which is the "cpu" string)
	cpu_sum="${cpu_now[@]:1}"
	# Replace the column seperator (space) with +
	cpu_sum=$((${cpu_sum// /+}))
	# Get the delta between two reads
	cpu_delta=$((cpu_sum - cpu_last_sum))
	# Get the idle time Delta
	cpu_idle=$((cpu_now[4] - cpu_last[4]))
	# Calc time spent working
	cpu_used=$((cpu_delta - cpu_idle))
	# Calc percentage
	cpu_usage=$((100 * cpu_used / cpu_delta))
	# Keep this as last for our next read
	cpu_last=("${cpu_now[@]}")
	cpu_last_sum=$cpu_sum

	# Wifi
	wifi_device=
	wifi_ssid=
	wifi_address=

	while read line
	do
		[ -z "$line" ] && break
		case "$line" in
			GENERAL.DEVICE:*)
				wifi_device=$(echo "$line" | sed 's/^[^ ]*\s*//')
				;;
			GENERAL.CONNECTION:*)
				wifi_ssid=$(echo "$line" | sed 's/^[^ ]*\s*//')
				;;
			"IP4.ADDRESS[1]:"*)
				wifi_address=$(echo "$line" | sed 's/^[^ ]*\s*//')
				;;
		esac
	done < <(nmcli dev show)

	# Battery
	battery_life=$(cat /sys/class/power_supply/BAT0/capacity)
	battery_icon=
	if [ "$battery_life" -gt "95" ]
	then
		battery_icon=""
	elif [ "$battery_life" -gt "65" ]
	then
		battery_icon=""
	elif [ "$battery_life" -gt "40" ]
	then
		battery_icon=""
	else
		battery_icon=""
	fi
	bar_battery="$battery_icon $battery_life%"

	# Volume
	volume_muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
	if [ "$volume_muted" = "yes" ]
	then
		volume_percentage=0%
		volume_level=0
	else
		volume_percentage=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')
		volume_level=${volume_percentage%?}
	fi
	volume_steps=9
	volume_cap=$((volume_level / 10))
	if [ "$volume_level" = "0" ]
	then
		volume_indicator=" "
	elif [ "$volume_level" -lt "30" ]
	then
		volume_indicator=" "
	elif [ "$volume_level" -lt "80" ]
	then
		volume_indicator=" "
	else
		volume_indicator=" "
	fi

	for ((i = 0; i <= $volume_steps; i++))
	do
		char=
		if [ ! "$volume_percentage" = "0%" ] && [ "$i" -le "$volume_cap" ]
		then
			if [ "$i" = 0 ]
			then
				char=""
			elif [ "$i" = "$volume_steps" ]
			then
				char=""
			else
				char=""
			fi
		else
			if [ "$i" = 0 ]
			then
				char=""
			elif [ "$i" = "$volume_steps" ]
			then
				char=""
			else
				char=""
			fi
		fi
		volume_indicator="$volume_indicator$char"
	done

	# Construct neko based on uptime :3
	cur_uptime=$(cat /proc/uptime)
	cur_uptime=${cur_uptime%.*}
	cur_uptime=${cur_uptime%.*}
	neko_ear_count=$((cur_uptime / 7200))
	neko_ears=
	if [ "$neko_ear_count" -gt 3 ]
	then
		neko_ear_count=3
	fi
	for ((i = 0; i < $neko_ear_count; i++))
	do
		neko_ears="$neko_ears"
	done

	# Construct all parts of the bar
	bar_neko="{\"align\":\"center\",\"short_text\":\"\",\"min_width\":\"     \",\"full_text\":\"$neko_ears    $neko_ears \"}"
	bar_date="{\"name\":\"id_time\",\"full_text\":\"$(date '+ %a %d-%m-%y  %T')\"}"
	bar_cpu="{\"name\":\"id_cpu\",\"min_width\":\" 100%\",\"full_text\":\" $cpu_usage%\"}"
	bar_ram="{\"name\":\"id_ram\",\"full_text\":\" `free -m | grep Mem: | awk '{print $3"/"$2" ("int(100*$3/$2)"%)"}'`\"}"
	bar_disk="{\"name\":\"id_disk\",\"full_text\":\" `df -m | grep /dev/sda1 | awk '{print ""$3"/"$2" ("$5")"}'`\"}"
	if [ "$wifi_device" = "lo" ]
	then
		bar_wifi="{\"name\":\"id_wifi\",\"short_text\":\"down\",\"full_text\":\"Internet down\"}"
	else
		bar_wifi="{\"name\":\"id_wifi\",\"short_text\":\"$wifi_ssid\",\"full_text\":\" $wifi_ssid $wifi_address\"}"
	fi
	bar_battery="{\"name\":\"id_bat\",\"min_width\":\" 100%\",\"full_text\":\"$battery_icon $battery_life%\"}"
	bar_volume="{\"name\":\"id_volume\",\"short_text\":\" $volume_percentage\",\"full_text\":\"$volume_indicator\"}"

	# Assemble the bar and send it off
	echo ",[$bar_neko,$bar_volume,$bar_battery,$bar_wifi,$bar_disk,$bar_ram,$bar_cpu,$bar_date]"
	sleep 1 &
	wait $!
done

#pid="$!"
#
## Wait for the window to open and grab its window ID
#winid=
#while :
#do
#    winid="`wmctrl -lp | awk -vpid=$pid '$3==pid {print $1; exit}'`"
#    [[ -z "${winid}" ]] || break
#done
#
## Focus the window we found
#wmctrl -ia "${winid}"
## Make it float
#i3-msg -q floating enable
#
## Move it to the center for good measure
#i3-msg -q move position center
