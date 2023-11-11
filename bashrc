#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

bind '"\t": menu-complete'

alias rm="rm -I"

alias ls="ls --color=auto"
alias grep="grep --color=auto"

alias pw="pwmgr"

mkcd() {
	mkdir "$1" && cd "$1"
}

g() {
	pattern="$1"
	files="$2"
	if [ -z "$files" ]
	then
		files="."
	fi
	grep -n -d recurse -D skip --binary-files=without-match --color=always -C 1 "$pattern" "$files" | less -R
}

export HISTCONTROL=erasedups
export HISTSIZE=5000
#history -r $HOME/.bash_favorite_history

export VISUAL=vim
export GIT_EDITOR="$VISUAL"
export EDITOR="$VISUAL"

git_ps1=$(git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /)
PS1="\n\[\e[1;37m\]<<< \[\e[1;34m\]\u\[\e[0;39m\]@\[\e[1;93m\]\h\[\e[0;94m\]:\[\e[1;93m\]\w\[\e[0;39m\]\[\e[1;35m\] $git_ps1\[\e[0;39m\]\[\e[1;37m\]>>>\[\e[0;39m\]\n\$ "

source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
