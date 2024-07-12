#!/bin/bash

config_dirs="systemd/user i3 i3status fcitx5 lf tmux yazi weechat"

mkdir -p $config_dirs

for d in $config_dirs
do
	rsync -a $HOME/.config/$d/ $d/
done

mkdir -p bin
cp /usr/local/bin/*.sh bin/

cp ~/.vim/pack/other/start/awesome-vim-colorschemes/colors/jellybeans.vim vim/colors/jellybeans.vim

mkdir -p neomutt
cp ~/.config/neomutt/{neomuttrc,mailcap,keybindings,colors} neomutt/

dots="screenrc gdbinit gvimrc vimrc zshrc bashrc XCompose xprofile Xresources gitconfig blerc xinitrc inputrc ratpoisonrc"
for d in $dots
do
	cp -r $HOME/.$d $d
done

cp /usr/share/fonts/Pixy.ttf Pixy.ttf

cp /usr/local/bin/*.sh bin/

cp ~/.config/picom.conf picom.conf

cp /etc/fonts/conf.d/* fontconfig/

pacman -Qqe > package-list.txt

rm -f weechat/sec.conf
rm -rf tmux/plugins
