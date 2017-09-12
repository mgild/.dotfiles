# install oh-my-zsh
if [[ ! -a "${HOME}/.oh-my-zsh" ]]; then
    # excludes ohmyzsh's default zshrc and prevents entering zshell on script finish
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh \
        | sed 's/env zsh//g'\
        | sed 's;cp $ZSH/templates/zshrc.zsh-template ~/.zshrc;;g' \
        | sed 's;mv -f ~/.zshrc-omztemp ~/.zshrc;;g')"
fi
