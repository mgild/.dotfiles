#! /bin/zsh

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

. "$CWD/.zshrc"
attemptInstall vim python ctags tmux
assertInstalled vim python ctags tmux

# setup zshrc
. "$CWD/zshrc-setup.sh";
. "$CWD/.zshrc"

# install pip
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
# Enter zsh shell
echo "Entering zsh"
exec zsh

