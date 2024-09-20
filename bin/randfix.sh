#!/bin/bash

MON1=HDMI-A-0
MON2=DVI-D-0

xrandr --output $MON1 --off
xrandr --output $MON2 --off
xrandr --output $MON1 --auto
xrandr --output $MON2 --auto
xrandr --output $MON1 --right-of $MON2
xrandr --output $MON1 --primary
