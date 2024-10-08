#!/bin/bash

DISPLAY=:0

# Check if already running
for pid in $(pidof -x "$(basename "$0")") ; do
    if [ "$pid" != "$$" ] ; then
        echo "tracker.sh is already running"
        exit 1
    fi
done

# Create the .tracks folder if it can
if [ ! -d "$HOME/.tracks" ] ; then
    mkdir "$HOME/.tracks" || { echo "could not create .tracks file in home directory :/" ; exit 1 ; }
fi

# Get the current active window and starting time
title="$(xdotool getwindowfocus getwindowname)"
start_time="$(date +%s.%N)"

# This table maps from window title to timings
declare -A titles

# If the script is exited and started again, it keeps multiple files which are differentiated by numbers (_0, _1, _2 etc.)
file_name="$HOME/.tracks/$(date +%Y-%m-%d)"
file_counter=0
while [ -f "${file_name}_$file_counter" ] ; do
    file_counter=$((file_counter+1))
done
file_name="${file_name}_$file_counter"

# Main loop with 1 second delay
while true ; do
    # This checks if the active window changed by comparing the titles
    new_title="$(xdotool getwindowfocus getwindowname)"
    if [ "$new_title" != "$title" ] ; then
        if [ -n "$title" ] ; then
            end_time="$(date +%s.%N)"
            # Append the start and end time to the track record
            prev_time="${titles["$title"]}"
            titles["$title"]="$prev_time $start_time $end_time"
            # Setup for the new active window
            title="$new_title"
            start_time="$end_time"
            # Write the titles table to the track file
            for t in "${!titles[@]}" ; do
                echo "$t"
                echo "${titles["$t"]}"
            done > "$file_name"
        fi
    fi
    sleep 1
done

