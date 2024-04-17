#!/bin/bash

config_dirs="systemd/user i3 i3status fcitx5 lf"

mkdir -p $config_dirs

for d in $config_dirs
do
	rm -rf $d/*
	cp -r $HOME/.config/$d/* $d/
done

mkdir -p bin
cp /usr/local/bin/*.sh bin/

cp ~/.vim/pack/other/start/awesome-vim-colorschemes/colors/jellybeans.vim vim/colors/jellybeans.vim

dots="screenrc gdbinit gvimrc vimrc zshrc bashrc XCompose xprofile Xresources"
for d in $dots
do
	cp -r $HOME/.$d $d
done

cp /usr/share/fonts/font.otb font.otb

cp /usr/local/bin/*.sh bin/

pacman -Qqe > package-list.txt
