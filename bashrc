#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#source /usr/share/blesh/ble.sh --noattach

###########
# options #
###########
shopt -s checkwinsize
shopt -s autocd

shopt -s histappend

###########
# aliases #
###########
alias sudo="sudo "

alias info="info --vi-keys"

alias rm="rm -I"
alias mv="mv -i"
alias cp="cp -i"

alias ls="eza"
alias ll="ls -l"
alias la="ll -A"
alias lt="ll -T"
alias lS="ls -r"
alias lL="ll -r"
alias lA="la -r"
alias lT="lt -r"

alias rg="rg -i"

alias fd="fd -H"

alias pw="pwmgr"

alias vi="vim -c 'set laststatus=0'"

alias alacritty='WINIT_X11_SCALE_FACTOR=1 alacritty'

alias play='vlc --novideo -I ncurses'

alias cd..='cd ..'

alias pc=purec

# clipboard copy
alias c="xclip -selection clipboard"

alias dl-song="yt-dlp -f bestaudio -x --audio-format flac --embed-thumbnail"

########################
# additional functions #
########################
mkcd() {
    mkdir "$@" && cd "$_"
}

y() {
    local tmp
    tmp="$(mktemp -t "yazi-cwd.XXXXXX")" || return
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    \rm -f -- "$tmp"
}

# clipboard copy with mime type
ci() {
    if [ $# -ne 1 ]
    then
        echo "ci: supply only a single argument"
        return
    fi
    printf "file://%s\r\n" "$(realpath "$1")" | xclip -selection clipboard -t text/uri-list
}

#############
# variables #
#############
export CPATH="/usr/include/freetype2"

export HISTCONTROL="erasedups:ignorespace"
# ALL SHALL BE SAVED
# There is a systemd service that optimizes the bash
# history every shutdown (removing duplicates)
export HISTSIZE=100000

export HISTTIMEFORMAT="%F %T "
#history -r $HOME/.bash_favorite_history
#export PROMPT_COMMAND="history -a; history -c history -r; $PROMPT_COMMAND"

export VISUAL=purec
export GIT_EDITOR="$VISUAL"
export EDITOR="$VISUAL"

export TERMINAL=alacritty

#######################
# command line string #
#######################
# <<< <user>@<host>:<directory path> <git branch> >>>
# $
#
# Example:
# <<< fairy@linuxpc:~/dotfiles * dotfiles >>>
# $
#
# Now simplified:
# < ~/dotfile * dotfiles >
# $
GIT_PS1="\$(git branch 2>/dev/null | grep -e '^\\*' | sed 's/\\* .\\+/\\\\0 /')"
#PS1="\n\[\e[1;37m\]<<< \[\e[1;34m\]\u\[\e[0;39m\]@\[\e[1;93m\]\h\[\e[0;94m\]:\[\e[1;93m\]\w\[\e[0;39m\]\[\e[1;35m\] $GIT_PS1\[\e[0;39m\]\[\e[1;37m\]>>>\[\e[0;39m\]\n\$ "
PS1="\n\[\e[1m\]"$'\u256d'" \[\e[0;96m\]\w\[\e[35m\] $GIT_PS1\[\e[39m\]\n\[\e[1m\]"$'\u251c'"\[\e[0m\]\$"

#########
# setup #
#########
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

# print repository this package is contained in
#repo_of()
#{
#    local cmd=$1
#    local pkgs
#    local FUNCNEST=10
#    set +o verbose
#    mapfile -t pkgs < <(pkgfile -b -- "$cmd" 2>/dev/null)
#    if [ ${#pkgs[@]} -gt 0 ]; then
#        echo "$cmd may be found in the following packages:"
#        IFS=$'\n'
#        echo "${pkgs[*]}"
#    else
#        echo "bash: $cmd: command not found"
#    fi 1>&2
#    return 127
#}

cur="$(tty)"

# only show the pony and move the cursor to line 32 for large enough terminals
if [ ! "$cur" = "/dev/tty1" ] && [ "$(tput lines)" -gt 50 ] ; then
    ponysay -q 2>/dev/null
    case "$cur" in
    "/dev/tty"*) ;;
    *)
        IFS='[;' read -p $'\e[6n' -d R -rs _ line _ _
        [ "$line" -lt 32 ] && tput cup 32 0
        ;;
    esac
fi

#[[ ${BLE_VERSION-} ]] && ble-attach

# start tmux/x11 automatically in the first tty
if [ "$cur" = "/dev/tty1" ] ; then
    #if ! tmux has-session -t 'default' 2>/dev/null
    #then
    #    tmux new -s 'default' -d 'neomutt' \; split-window -v 'weechat'
    #fi
    startx
fi
