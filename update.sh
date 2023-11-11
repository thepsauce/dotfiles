#!/bin/bash

config_dirs="systemd/user i3 i3status fcitx5"

mkdir -p $config_dirs

for d in $config_dirs
do
	cp -r $HOME/.config/$d/* $d/
done

mkdir -p bin
cp /usr/local/bin/*.sh bin/

dots="vimrc bashrc XCompose xsession xprofile Xmodmap Xresources"
for d in $dots
do
	cp -r $HOME/.$d $d
done

cp /usr/local/bin/*.sh bin/

pacman -Qqe > package-list.txt
