#!/bin/bash

files=$(ls /usr/share/kbd/consolefonts)

for f in $files
do
	setfont -16 $f
	echo $f
	showconsolefont
	read -n 1
done
