#! /bin/zsh
set -e
path=(
    # python 2.7 user bin on osx
    ${HOME}/Library/Python/2.7/bin
    # user builds
    ${HOME}/{.,}local/bin
    # Homebrew packages, go executables, gnu bin
    /usr/local/opt{/go/libexec/bin,/coreutils/libexec/gnubin,}
    # default paths
    /{usr/,}{local/,}{s,}bin
)
# Join path and export
export PATH=${(j/:/)path}
export ZSH=~/.oh-my-zsh
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

assertInstalled git zsh vim
CWD="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

. "$CWD/setup_files/moveSrcs.sh";

. "$CWD/setup_files/vim-setup.sh";
. "$CWD/setup_files/tmux-setup.sh";
. "$CWD/setup_files/powerline-setup.sh";
. "$CWD/setup_files/fzf-setup.sh";
. "$CWD/setup_files/ohmyzsh-setup.sh";
. "$CWD/setup_files/plugin-setup.sh";
. "$CWD/setup_files/zshrc-setup.sh";
# Enter zsh shell
echo "Entering zsh"
exec zsh

