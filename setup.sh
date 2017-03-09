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

assertInstalled zsh vim wget python pip git cmake ctags tmux

CWD="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

. $CWD/moveSrcs.sh

# Symlink the vimrc
ln -s $CWD/.vimrc ~/
# link zshrc
ln -s $CWD/.zshrc ~/
ln -s $CWD/.zshrc.alias ~/
ln -s $CWD/.zpreztorc ~/

# link tmux conf
ln -s "$CWD/.tmux.conf" "${HOME}"  

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
if [[ ! -a "${HOME}/.zprezto" ]]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    setopt EXTENDED_GLOB
    for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
        ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    done 
fi

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

