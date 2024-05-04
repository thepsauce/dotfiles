#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source /usr/share/blesh/ble.sh --noattach
set -o vi

shopt -s checkwinsize

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

bind '"\t": menu-complete'

alias sudo="sudo "

alias rm="rm -I"

alias ll="ls -l"
alias la="ls -lA"

alias fd="fd -H"

alias pw="pwmgr"

alias vi="vim -c 'set laststatus=0'"

alias ls="exa"

alias alacritty='WINIT_X11_SCALE_FACTOR=1 alacritty'

alias play='mpv --no-audio-display --no-video'

mkcd() {
	mkdir $@ && cd "$_"
}

cdb() {
	cd ~/ext || return 1
	if [ -n "$1" ]
	then
		cd "$1"
	fi
}

cdc() {
	cd ~/ext2 || return 1
	if [ -n "$1" ]
	then
		cd "$1"
	fi
}

y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

export CPATH="/usr/include/freetype2"

export HISTCONTROL="erasedups:ignorespace"
export HISTSIZE=20000
#history -r $HOME/.bash_favorite_history

export VISUAL=vim
export GIT_EDITOR="$VISUAL"
export EDITOR="$VISUAL"

git_ps1=$(git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /)
PS1="\n\[\e[1;37m\]<<< \[\e[1;34m\]\u\[\e[0;39m\]@\[\e[1;93m\]\h\[\e[0;94m\]:\[\e[1;93m\]\w\[\e[0;39m\]\[\e[1;35m\] $git_ps1\[\e[0;39m\]\[\e[1;37m\]>>>\[\e[0;39m\]\n\$ "

screen_cd() {
	cd "$@"
	if [ -n "$STY" ]
	then
		screen -X chdir "$@"
	fi
}

alias cd=screen_cd

lf_cd() {
	cd "$(/home/steves/.config/lf/lf-wrapper.sh -print-last-dir "$@")"
}

alias lf=lf_cd

alias z=zoxide

eval "$(zoxide init bash)"

# clipboard copy
alias c="xclip -selection clipboard"

# clipboard copy with mime type
ci() {
	file="$1"
	shift
	mime_type=$(file -Lb --mime-type -- "$file")
	xclip -selection clipboard -t $mime_type "$file" $@
}

source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
source /usr/share/doc/pkgfile/command-not-found.bash

[[ ${BLE_VERSION-} ]] && ble-attach

# start tmux automatically in the first tty
WHO="$(who am i | awk '{print $2}')"
if [ "$WHO" = "tty1" ]
then
	tmux
fi
