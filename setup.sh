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
assertInstalled zsh vim wget python pip git cmake ctags tmux
CWD="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

if test "$(uname -s)" = "Darwin"; then
    . "$CWD/osxsetup.sh";
fi

. "$CWD/moveSrcs.sh";

. "$CWD/zshrc-setup.sh";

. "$CWD/vim-setup.sh";

. "$CWD/ohmyzsh-setup.sh";

. "$CWD/plugin-setup.sh";

. "$CWD/tmux-setup.sh"

. "$CWD/powerline-setup.sh";

# Enter zsh shell
zsh

