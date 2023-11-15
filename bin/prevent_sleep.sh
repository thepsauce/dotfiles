#!/bin/bash

if pulsemixer --list | grep -q "Name: qutebrowser"
then
	xset s off
else
	xset s on
fi
