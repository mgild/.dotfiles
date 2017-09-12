# install oh-my-zsh
if [[ ! -a "${HOME}/.oh-my-zsh" ]]; then
    . "$CWD/ohmyzsh_build.sh"
fi

: . "$CWD/.ohmyzshrc"
