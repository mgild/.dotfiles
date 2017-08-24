#! /bin/zsh
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

CWD="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

if test "$(uname -s)" = "Darwin"; then
    . "$CWD/osxsetup.sh";
elif test "$(uname -s)" = "Linux"; then
    . "$CWD/linuxsetup.sh";
fi

attemptInstall zsh vim python pip git ctags tmux
assertInstalled zsh vim python pip git ctags tmux

. "$CWD/moveSrcs.sh";

. "$CWD/zshrc-setup.sh";

. "$CWD/vim-setup.sh";

. "$CWD/ohmyzsh-setup.sh";

. "$CWD/plugin-setup.sh";

. "$CWD/tmux-setup.sh";

. "$CWD/powerline-setup.sh";

. "$CWD/fzf-setup.sh";
# Enter zsh shell
zsh

