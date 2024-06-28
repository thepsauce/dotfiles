#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#source /usr/share/blesh/ble.sh --noattach

###########
# options #
###########
set -o vi

shopt -s checkwinsize
shopt -s autocd

shopt -s histappend

###########
# aliases #
###########
alias sudo="sudo "

alias rm="rm -I"
alias mv="mv -i"
alias cp="cp -i"

alias ls="eza --icons=automatic"
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

alias play='mpv --no-audio-display --no-video'

screen_cd() {
    cd "$@" || return
    if [ -n "$STY" ]
    then
        screen -X chdir "$(pwd)"
    fi
}

alias cd=screen_cd

lf_cd() {
    cd "$(/home/steves/.config/lf/lf-wrapper.sh -print-last-dir "$@")"
}

alias lf=lf_cd

# clipboard copy
alias c="xclip -selection clipboard"

#########
# binds #
#########
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

bind '"\t": menu-complete'

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

export VISUAL=vim
export GIT_EDITOR="$VISUAL"
export EDITOR="$VISUAL"

export TERMINAL=alacritty

#######################
# command line string #
#######################
# <<< <user>@<host>:<directory path> <git branch> >>>
# $
# Example:
# <<< fairy@linuxpc:~/dotfiles * dotfiles >>>
# $
GIT_PS1="\$(git branch 2>/dev/null | grep -e '^\\*' | sed 's/\\* .\\+/\\\\0 /')"
export PS1="\n\[\e[1;37m\]<<< \[\e[1;34m\]\u\[\e[0;39m\]@\[\e[1;93m\]\h\[\e[0;94m\]:\[\e[1;93m\]\w\[\e[0;39m\]\[\e[1;35m\] $GIT_PS1\[\e[0;39m\]\[\e[1;37m\]>>>\[\e[0;39m\]\n\$ "

#########
# setup #
#########
eval "$(zoxide init bash --cmd cd)"

alias cd..='cd ..'

# hacky workaround to make autocd work correctly
function __zoxide_z() {
    if [ $# -eq 2 ] && [ "$1" = "--" ]
    then
        shift
    fi
    # shellcheck disable=SC2199
    if [ $# -eq 0 ]
    then
        __zoxide_cd ~
    elif [ $# -eq 1 ] && [ "$1" = "-" ]
    then
        __zoxide_cd "${OLDPWD}"
    elif [ $# -eq 1 ] && [ -d "$1" ]
    then
        __zoxide_cd "$1"
    elif [[ ${@: -1} == "${__zoxide_z_prefix}"?* ]]
    then
        # shellcheck disable=SC2124
        local result="${@: -1}"
        __zoxide_cd "${result:${#__zoxide_z_prefix}}"
    else
        local result
        # shellcheck disable=SC2312
        result="$(\command zoxide query --exclude "$(__zoxide_pwd)" -- "$@")" &&
            __zoxide_cd "${result}"
    fi
}

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
    if ! tmux has-session -t 'default' 2>/dev/null
    then
        tmux new -s 'default' -d 'neomutt' \; split-window -v 'weechat'
    fi
    startx
fi

