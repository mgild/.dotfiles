# Ensure custom zsh plugins are downloaded
if [[ ! -d  $ZSH_CUSTOM/plugins/fast-syntax-highlighting ]]; then
    git clone https://github.com/zdharma/fast-syntax-highlighting.git $ZSH_CUSTOM/plugins/fast-syntax-highlighting
fi

if [[ ! -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]]; then
    git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

if [[ ! -d $ZSH_CUSTOM/plugins/zsh-git-prompt ]]; then
    git clone https://github.com/olivierverdier/zsh-git-prompt.git $ZSH_CUSTOM/plugins/zsh-git-prompt
fi

# Link tab completion (custom plugin taken from prezto)
ln -sfn $CWD/bin/custom_plugins/tab-completion $ZSH_CUSTOM/plugins/tab-completion


