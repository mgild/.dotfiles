#! /bin/zsh
# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$ZSH/custom

function assertInstalled() {
    for var in "$@"; do
        if ! which $var &> /dev/null; then
            echo "Install $var!"
            exit 1
        fi
    done
}

assertInstalled zsh vim wget python pip git cmake ctags tmux rainbarf

CWD="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

. $CWD/moveSrcs.sh

# Symlink the vimrc
ln -s $CWD/.vimrc ~/

# install Vundle
if [[ ! -a "${HOME}/.vim/bundle/Vundle.vim" ]]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
# install vim pluigns
vim -E -c "PluginInstall" -c "q" -c "q"
# Remove old colors and symlink the theme bundle
mv ~/.vim/colors  ~/.vim/colors.old
ln -s ~/.vim/bundle/vim-colorschemes/colors ~/.vim/colors
# install oh-my-zsh
if [[ ! -a "${HOME}/.oh-my-zsh" ]]; then
    sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sed 's/env zsh//g')"
    # Remove the newly created zshrc
    rm ~/.zshrc
fi

# Ensure custom plugins are downloaded
if [[ ! -d  $ZSH_CUSTOM/plugins/zsh-syntax-highlighting ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

if [[ ! -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]]; then
    git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

if [[ ! -d $ZSH_CUSTOM/plugins/zsh-git-prompt ]]; then
    git clone https://github.com/olivierverdier/zsh-git-prompt.git $ZSH_CUSTOM/plugins/zsh-git-prompt
fi

# link zshrc
ln -s $CWD/.zshrc ~/
ln -s $CWD/.zshrc.alias ~/

# link tmux conf
ln -s "$CWD/.tmux.conf" "${HOME}"  

# setup powerline
pip install --user git+git://github.com/Lokaltog/powerline
pip install netifaces --user
POWERLINE_ROOT="$(pip show powerline-status | grep '^Location: ' | sed 's/^Location: //')/powerline"
powerline_config="$POWERLINE_ROOT/config_files"
if [ ! -L $powerline_config ]; then
    mv $powerline_config $powerline_config.old
    ln -s "$CWD/powerline_config" "$powerline_config"
    ln -s "$POWERLINE_ROOT/bindings/tmux/powerline.conf" "${HOME}" 
fi

# install powerline fonts
if [[ ! -d ${HOME}/.powerline_fonts ]]; then
    git clone https://github.com/powerline/fonts.git ~/.powerline_fonts
    bash ${HOME}/.powerline_fonts/install.sh
fi

# Download and build YouCompleteMe compiler
if [[ ! -a ${HOME}/.vim/bundle/youcompleteme/third_party/ycmd/ycm_core.so ]]; then
    python ~/.vim/bundle/youcompleteme/install.py --clang-completer
fi


# Enter zsh shell
zsh

