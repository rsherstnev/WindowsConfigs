HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=10000
HISTIGNORE="history:ls:lla:la:ll:cd:clear:cls"
HISTTIMEFORMAT='%d.%m.%Y %H:%M:%S '

shopt -s histappend
shopt -s checkwinsize
shopt -s autocd
shopt -s cmdhist

_COLOR1="\e[01;38;5;001m"     # USERNAME
_COLOR2="\e[01;38;5;144m"     # DELIMETER
_COLOR3="\e[01;38;5;216m"     # HOSTNAME
_COLOR4="\e[01;38;5;109m"     # CURRENT DIR
_COLOR5="\e[01;38;5;72m"      # GIT
_COLOR_RESET="\e[0m"          # RESET COLOR

git_info() {
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null)

    if [[ -n $branch ]]; then
        local status=$(git status --porcelain 2>/dev/null)
        
        if [[ -n $status ]]; then
            echo "${_COLOR5}(${branch}*)${_COLOR_RESET}"
        else
            echo "${_COLOR5}(${branch})${_COLOR_RESET}"
        fi
    fi
}

PS1="┌──($_COLOR1\u$_COLOR2@$_COLOR3\h$_COLOR_RESET)-[$_COLOR4\w$_COLOR_RESET] $(git_info)\n└─# "

export GREP_COLORS='ms=01;33'

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

tabs -4