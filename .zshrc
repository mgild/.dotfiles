
# Path extensions
path=(
    # X11
    "/opt/X11/bin"
    # user builds
    ${HOME}/{.,}local/bin
    # Latex tools
    "/Library/TeX/texbin"
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
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

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

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/dsa_id"


#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }



#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
ii() {
    RED=$fg[red]
    NC=$reset_color
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Current network location :$NC " ; scselect
    echo -e "\n${RED}Public IP Address :$NC " ;myip
    echo -e "\n${RED}Local IP Address :$NC " ;localip
    echo
}


# Set less options
# -------------------------------------------------------
LESS=-asrRix8


# Colored Man Pages
# -------------------------------------------------------
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;33;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;146m'


#  Show symlinks in given directory
#   -----------------------------------------------------
function lsym() {
    for link in $(find ${1:-"$(pwd)"} -maxdepth 1 -type l); do
        echo "$link -> $(readlink $link)";
    done;
}

min() {
    ((( $1 < $2 )) && echo $1) || echo $2
}
# Quick up n levels
# Requires: n >= 0
function up() {
    declare -i d=${@:-1}
    if (( $d < 0 )); then
        echo "up: Error: must specifiy a non-negative value";
        return 1;
    fi
    dest=$(pwd | sed -E 's;(/[^/]*){0,'$d'}$;;');
    cd ${dest:-"/"};
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
    while read data; do
        echo -n $sep$data;
        sep=$1;
    done;
    echo;
}

isset() {
    which "$@" &> /dev/null
}

