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
    # Linuxbrew
    {/home/linuxbrew,${HOME}}/.linuxbrew/bin
    # custom python build path from dotfiles script
    ${HOME}/python-dev/bin
)
# Join path and export
export PATH=${(j/:/)path}
export ZSH=~/.oh-my-zsh
ZSH_CUSTOM=$ZSH/custom

if [[ $EUID == 0 ]]; then
   echo "Don't run setup as root!"
   exit 1
fi

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

assertInstalled ruby git zsh curl make gcc
CWD="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

if test "$(uname -s)" = "Darwin"; then
    . "$CWD/bin/osxsetup.sh";
elif test "$(uname -s)" = "Linux"; then
    . "$CWD/bin/linuxsetup.sh";
fi

. "$CWD/bin/moveSrcs.sh";
attemptInstall vim python ctags tmux
assertInstalled vim python tmux

# install pip
if ! which pip &> /dev/null; then
    curl -fssL "https://bootstrap.pypa.io/get-pip.py" > /tmp/get-pip.py
    python /tmp/get-pip.py --user --force
fi

. "$CWD/bin/vim-setup.sh";
. "$CWD/bin/tmux-setup.sh";
. "$CWD/bin/powerline-setup.sh";
. "$CWD/bin/fzf-setup.sh";
. "$CWD/bin/ohmyzsh-setup.sh";
. "$CWD/bin/plugin-setup.sh";
. "$CWD/bin/zshrc-setup.sh";
# Enter zsh shell
echo "Entering zsh"
exec zsh

