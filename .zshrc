
export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color
#alias tmux='tmux -2'
# Path extensions
path=(
    # Latex tools (osx)
    /Library/TeX/texbin
    # X11
    /opt/X11/bin
    # user builds
    ${HOME}/{.,}local/bin
    # Homebrew packages
    /usr/local/opt{/coreutils/libexec/gnubin,}
    # default paths
    /{usr/,}{local/,}{s,}bin
)
# Join path and export
export PATH=${(j/:/)path}
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

source ${HOME}/.ohmyzshrc

# load iterm intergration (if it exists)
test -e "${HOME}/.iterm2_shell_integration.zsh" && . "${HOME}/.iterm2_shell_integration.zsh"

# Load non-public zshrc
test -f ~/.zshrc.local && source ~/.zshrc.local
# source alias file
source ~/.zshrc.alias

# Set left justified prompt
PROMPT='${ret_status} %{$fg[cyan]%}%c%{$reset_color%}$(git_super_status) '
# Set the right justified prompt
# RPROMPT='%{$fg[blue]%}$(localip)%{$reset_color%}'

# Preferred editor
export EDITOR=vim
export VISUAL=$EDITOR

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/dsa_id"


#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }

# Set less options
# -------------------------------------------------------
export LESS=-asrRix8


#  Show symlinks in given directory
#   -----------------------------------------------------
function lsym() {
    for link in $(find ${1:-"$(pwd)"} -maxdepth 1 -type l); do
        echo "$link -> $(readlink $link)";
    done;
}

min() {
    ((($1 < $2)) && echo $1) || echo $2
}
# Quick up n levels
# Requires: n >= 0
up() {
    # default to 1
    declare -i d=${@:-1};
    # ensure non-negative
    (($d < 0)) && (>&2 echo "up: Error: negative value provided") && return 1;
    # remove last d directories from pwd, append "/" in case result is empty
    cd "$(pwd | sed -E 's;(/[^/]*){0,'$d'}$;;')/";
}

# Better man
# Find man page for builtin commands easily
# If not a builtin, works like normal man
# Sets man colors
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;33;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;146m'
man() {
    vartype=$(type "$@");
    if [[ $vartype == *"shell builtin" || $vartype == *"reserved word" ]]; then
        command man zshbuiltins | less -p "^       $@ ";
    else
        command man "$@";
    fi;
}

# Security checks
alias checkrootkits="sudo rkhunter --update; sudo rkhunter --propupd; sudo rkhunter --check"

# nullpointer url shortener
short() {
    if [[ -z $1 ]]; then
        return 1;
    fi
    link=$(curl -s -F"shorten=$*" https://0x0.st | sed 's;https://;;g')
    echo $link "copied to clipboard" && printf $link | pbcopy
}

#   weather: pass your city or zip code, and it returns the weather!
#   USAGE - weather cleveland
#         OR
#         weather 44106
#   WARNING - city and zip code args may yield inaccurate/different results.
#   ------------------------------------------------------
weather() { curl wttr.in/"$1"; }

# split string into multiple lines(array). Supports regex
split(){
    awk -F "$1" '{ for (i=1; i<=NF;++i){print $i;} }'
}

# join input lines on pattern
join() {
    sep=''
    while read data; do
        echo -n $sep$data;
        sep=$1;
    done;
    echo;
}

isset() {
    which "$@" &> /dev/null
}

# run commands in the background
background() {
    nohup zsh -c "$@" &
}

grep_dir() {
    grep -RnisI "$@" * --color=always
}

qaz() {
    echo 'q w e rt | yu i o p'
    echo 'a s d fg | hj k l ;'
    echo 'z x c vb | nm , . /'
}

