#! /bin/zsh
CWD="$(cd -P -- "$(dirname -- "$0")" && pwd -P)" 

. $CWD/moveSrcs.sh

# Symlink the vimrc
ln -s $CWD/.vimrc ~/

# install Vundle
if [[ ! -a "${HOME}/.vim/bundle/Vundle.vim" ]]
then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
# install vim pluigns
vim -E -c "PluginInstall" -c "q" -c "q"
# Remove old colors and symlink the theme bundle
mv ~/.vim/colors  ~/.vim/colors.old
ln -s ~/.vim/bundle/vim-colorschemes/colors ~/.vim/colors
# install oh-my-zsh
if [[ ! -a "${HOME}/.oh-my-zsh" ]]
then
    sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sed 's/env zsh//g')"
    # Remove the newly created zshrc
    rm ~/.zshrc
fi

# link zshrc
ln -s $CWD/.zshrc ~/

# Do the initial installs in zshrc
.  ~/.zshrc

# install powerline fonts
if [[ ! -d ${HOME}/.fonts ]]
then
    wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
    mkdir -p ~/.fonts/ && mv PowerlineSymbols.otf ~/.fonts/
    fc-cache -vf ~/.fonts
    mkdir -p ~/.config/fontconfig/conf.d/ && mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
fi

# Download and build YouCompleteMe compiler
if [[ ! -a ${HOME}/.vim/bundle/youcompleteme/third_party/ycmd/ycm_core.so ]]
then
    python ~/.vim/bundle/youcompleteme/install.py --clang-completer || echo "Please make sure you have installed the specified prerequisites"
fi


# Enter zsh shell
zsh

