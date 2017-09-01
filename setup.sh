#! /bin/zsh

if [[ $EUID == 0 ]]; then
   echo "Don't run setup as root!"
   exit 1
fi

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$ZSH/custom

function assertInstalled() {
    local success=true
    for var in "$@"; do
        if ! which $var &> /dev/null; then
            echo "Install $var!"
            success=false
        fi
    done
    $success || exit 1
}

function attemptInstall() {
    for var in "$@"; do
        if ! which $var &> /dev/null; then
            brew install $var
        fi
    done
}

assertInstalled ruby git zsh curl wget gcc make
CWD="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

if test "$(uname -s)" = "Darwin"; then
    . "$CWD/osxsetup.sh";
elif test "$(uname -s)" = "Linux"; then
    . "$CWD/linuxsetup.sh";
fi

. "$CWD/moveSrcs.sh";

attemptInstall vim python ctags tmux
# alias python if brew only installed python under python2
if which python2 &> /dev/null && ! which python &> /dev/null; then
    alias python='python2';
fi
assertInstalled vim python ctags tmux

# install pip
source "$CWD/.zshrc"
if ! which pip &> /dev/null; then
    curl -fssL "https://bootstrap.pypa.io/get-pip.py" > /tmp/get-pip.py
    python /tmp/get-pip.py --user --force
fi

. "$CWD/vim-setup.sh";
. "$CWD/tmux-setup.sh";
. "$CWD/powerline-setup.sh";
. "$CWD/fzf-setup.sh";
. "$CWD/ohmyzsh-setup.sh";
. "$CWD/plugin-setup.sh";
. "$CWD/zshrc-setup.sh";
# Enter zsh shell
echo "Entering zsh"
exec zsh

