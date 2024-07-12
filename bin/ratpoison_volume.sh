#!/bin/bash

mute="$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')"
if [ "$mute" = "yes" ] ; then
    volume="$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')"
    ratpoison -c "echo Volume: $volume"
else
    ratpoison -c "echo Volume: muted"
fi
