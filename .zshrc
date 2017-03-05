# Path extensions
path=(
    # default bin paths
    "/usr/local/bin"
    "/usr/bin"
    "/bin"
    # default sbin paths
    "/usr/local/sbin"
    "/usr/sbin"
    "/sbin"
    # X11
    "/opt/X11/bin"
    # Homebrew
    "/usr/local/opt"
    # Powerline
    "${HOME}/.local/bin"
)
# Join path and export
export PATH=${(j/:/)path}

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="robbyrussell"
#ZSH_THEME="random"
# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$ZSH/custom


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(z git brew heroku osx vundle npm nmap python sublime)
. $ZSH/plugins/z/z.sh

# load iterm intergration (if it exists)
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# load oh-my-zsh
source $ZSH/oh-my-zsh.sh
# set custom git prompt
source $ZSH_CUSTOM/plugins/zsh-git-prompt/zshrc.sh
if [[ $ZSH_EVAL_CONTEXT == 'file' ]]; then
  source "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
  source "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

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
    for link in $(find ${1:-"$(pwd)"} -maxdepth 1 -type l); do echo "$link -> $(readlink $link)"; done;
}

min() {
    ((( $1 < $2 )) && echo $1) || echo $2
}
# Quick up n levels
function up() {
    declare -i depth=$(pwd | awk -F/ '{ print NF - 1 }')
    # convert to int
    declare -i var=$(min ${1:-1} $depth);
    # is not a positive integer
    if  (( ! $var > 0 )); then
        echo "Must pass in a positive integer or no argument" && return 1;
    fi
    res="";
    for (( i = 0; i < $var; ++i )); do
        res=$res"../";
    done
    cd $res;
}

# Load non-public zshrc
test -f ~/.zshrc.local && source ~/.zshrc.local

# Security checks
alias checkrootkits="sudo rkhunter --update; sudo rkhunter --propupd; sudo rkhunter --check"


email() {
    echo $3 | mutt -s $2 $1
}
# colorized cat
c() {
    for file in "$@"
    do
        pygmentize -f console256 -g "$file"
    done
}


# nullpointer url shortener
short() {
    if [[ -z $1 ]]; then
        return 1;
    fi
    link=$(curl -s -F"shorten=$*" https://0x0.st | sed 's/https:\/\///g')
    echo $link "copied to clipboard" && printf $link | pbcopy
}

#   To make slacking off faster
#   -----------------------------------------------------
reddit() {
    sub=""
    if [[ ! -z $1 ]]; then
        sub="r/$1"
    fi
    open https://reddit.com/$sub
}

#   weather: pass your city or zip code, and it returns the weather!
#   USAGE - weather cleveland
#         OR
#         weather 44106
#   WARNING - city and zip code args may yield inaccurate/different results.
#   ------------------------------------------------------
weather() { curl wttr.in/"$1"; }

elocate() {
    locate $1 | grep "/$1$"
}

# split string into multiple lines(array). Supports regex 
split(){
    awk -F "$1" '{ for (i=1; i<=NF;++i){print $i;} }'
}

# join input lines on pattern
join() {
    local isfirst=true
    while read data; do
        echo -n $sep$data
        $isfirst && local sep=$1
        local isfirst=false
    done
    echo
}

isset() {
    VAR=$1
    VALUE=$(eval "echo \$$VAR")
    if [ -z "$VALUE" ]; then
#        log "Var $VAR is not set." INFO
        return 1
    else
#        log "Var $VAR is set to $VALUE." INFO
        return 0
    fi
}

