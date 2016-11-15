# Path extensions
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Library/TeX/texbin"
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH="/usr/local/sbin:$PATH"

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
plugins=(z git brew heroku osx vundle npm nmap python sublime zsh-autosuggestions zsh-syntax-highlighting)
. $ZSH/plugins/z/z.sh

# load iterm intergration (if it exists)
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# load oh-my-zsh
source $ZSH/oh-my-zsh.sh
# set custom git prompt
source $ZSH_CUSTOM/plugins/zsh-git-prompt/zshrc.sh
# Set left justified prompt
PROMPT='${ret_status} %{$fg[cyan]%}%c%{$reset_color%}$(git_super_status) '
# Set the right justified prompt
RPROMPT=""

# Preferred editor
export EDITOR=vim

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/dsa_id"


#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }



#   NETWORKING
#   ---------------------------
alias myip='wget http://ipinfo.io/ip -qO - | head -n 1' # myip:         Public facing IP Address
alias netCons='lsof -i'                                 # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'                # flushDNS:     Flush out the DNS Cache
alias lsock='sudo lsof -i -P'                           # lsock:        Display open sockets
alias lsockU='sudo lsof -nP | grep UDP'                 # lsockU:       Display only open UDP sockets
alias lsockT='sudo lsof -nP | grep TCP'                 # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'                  # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'                  # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'            # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                      # showBlocked:  All ipfw rules inc/ blocked IPs


#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
ii() {
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Current network location :$NC " ; scselect
    echo -e "\n${RED}Public facing IP Address :$NC " ;myip
    echo
}

#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------------------
alias memHogsTop='top -l 1 -o rsize | head -20'
alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'
function mem_stat() { vm_stat | perl -ne '/page size of (\d+)/ and $size=$1; /Pages\s+([^:]+)[^\d]+(\d+)/ and printf("%-16s % 16.2f Mi\n", "$1:", $2 * $size / 1048576);'}

#   cpuHogs:  Find CPU hogs
#   -----------------------------------------------------
alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

#   Common misspellings
#   -----------------------------------------------------
alias pyhton=python
alias mkae=make

#   Git Smart Log
#   -----------------------------------------------------
alias gsl='git log --all --decorate --oneline --graph'

#   Never use vi
#   -----------------------------------------------------
alias vi=vim

#   Better interactive python
#   -----------------------------------------------------
alias ipython="python -m IPython"

#  Show symlinks in given directory 
#   -----------------------------------------------------
function lsym() {
    dir=".";
    if [[ $1 ]]; then;
        dir=($1)
    fi
    find $dir -maxdepth 1 -type l -ls;
}

# Quick up n levels
function up() {
    var=$1
    if [[ -z $var ]]; then
        var=(1)
    fi
    # is not an integer
    if  [[ ! $var =~ ^[[:digit:]]+$ ]]; then
        echo "Must pass in a non-negative integer" && return 1
    fi
    for (( i = 0; i < $var; i++ )); do
        cd ..
    done
}

# Load non-public zshrc
test -f ~/.zshrc.local && source ~/.zshrc.local
