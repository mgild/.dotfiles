#! /bin/zsh
ln -s ~/.dotfiles/.zshrc ~/
ln -s ~/.dotfiles/.vimrc ~/
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
    sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi

