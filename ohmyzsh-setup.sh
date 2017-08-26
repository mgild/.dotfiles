# install oh-my-zsh
if [[ ! -a "${HOME}/.oh-my-zsh" ]]; then
    # excludes ohmyzsh's default zshrc and prevents entering zshell on script finish
    sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - \
        | sed 's/env zsh//g'\
        | sed 's;mv -f ~/.zshrc-omztemp ~/.zshrc;;g')"
    # Remove the newly created zshrc
    rm ~/.zshrc
fi
