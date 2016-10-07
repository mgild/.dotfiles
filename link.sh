#! /bin/bash
CWD="$(cd -P -- "$(dirname -- "$0")" && pwd -P)" 
ln -s $CWD/.vimrc ~/
# install Vundle
if [[ ! -a "${HOME}/.vim/bundle/Vundle.vim" ]]
then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
# install vim pluigns
vim -E -c "PluginInstall" -c "q" -c "q"
# Remove old colors and symlink the theme bundle
rm -rf ~/.vim/colors
ln -s ~/.vim/bundle/vim-colorschemes/colors ~/.vim/colors
# install oh-my-zsh
if [[ ! -a "${HOME}/.oh-my-zsh" ]]
then
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed "s/env zsh//g")"
    # stop oh-my-zsh from auto zsh overwrite
    rm ~/.zshrc
fi
echo "linking $CWD/.zshrc"
ln -s $CWD/.zshrc ~/


