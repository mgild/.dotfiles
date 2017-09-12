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

assertInstalled ruby git zsh curl gcc make
CWD="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

if test "$(uname -s)" = "Darwin"; then
    . "$CWD/osxsetup.sh";
elif test "$(uname -s)" = "Linux"; then
    . "$CWD/linuxsetup.sh";
fi

. "$CWD/moveSrcs.sh";
attemptInstall vim python ctags tmux
assertInstalled vim python ctags tmux

# install pip
if ! which pip &> /dev/null; then
    curl -fssL "https://bootstrap.pypa.io/get-pip.py" > /tmp/get-pip.py
    python /tmp/get-pip.py --user --force
fi

. "$CWD/zshrc-setup.sh";
. "$CWD/vim-setup.sh";
. "$CWD/tmux-setup.sh";
. "$CWD/powerline-setup.sh";
. "$CWD/fzf-setup.sh";
. "$CWD/ohmyzsh-setup.sh";
. "$CWD/plugin-setup.sh";
# Enter zsh shell
echo "Entering zsh"
exec zsh

