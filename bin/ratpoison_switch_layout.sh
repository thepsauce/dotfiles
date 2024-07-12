#!/bin/bash

setxkbmap -query | grep -E -q "variant:\s*colemak"

if [ $? = 0 ]
then
	setxkbmap -layout us
	ratpoison -c "echo switched to us (no variant)"
else
	setxkbmap -layout us -variant colemak
	ratpoison -c "echo switched to us (colemak)"
fi
