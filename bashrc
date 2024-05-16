# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source /usr/share/blesh/ble.sh --noattach

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
    cd $@
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
    mkdir $@ && cd "$_"
}

y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    \rm -f -- "$tmp"
}

# clipboard copy with mime type
ci() {
    file="$1"
    shift
    mime_type=$(file -Lb --mime-type -- "$file")
    xclip -selection clipboard -t $mime_type "$file" $@
}

#############
# variables #
#############
export CPATH="/usr/include/freetype2"

export HISTCONTROL="erasedups:ignorespace"
export HISTSIZE=20000

export HISTTIMEFORMAT="%F %T "
#history -r $HOME/.bash_favorite_history

export VISUAL=vim
export GIT_EDITOR="$VISUAL"
export EDITOR="$VISUAL"

export TERMINAL=$TERM

#######################
# command line string #
#######################
git_ps1=$(git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /)
PS1="\n\[\e[1;37m\]<<< \[\e[1;34m\]\u\[\e[0;39m\]@\[\e[1;93m\]\h\[\e[0;94m\]:\[\e[1;93m\]\w\[\e[0;39m\]\[\e[1;35m\] $git_ps1\[\e[0;39m\]\[\e[1;37m\]>>>\[\e[0;39m\]\n\$ "

#########
# setup #
#########
eval "$(zoxide init bash --cmd cd)"

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
        result="$(\command zoxide query --exclude `__zoxide_pwd` -- $@)" &&
            __zoxide_cd "${result}"
    fi
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
