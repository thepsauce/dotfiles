#!/bin/bash

setxkbmap -query | grep -E -q "variant:\s*colemak"

if [ $? = 0 ]
then
	setxkbmap -layout us
else
	setxkbmap -layout us -variant colemak
fi
