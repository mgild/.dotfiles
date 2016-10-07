ln -s ~/.dotfiles/.zshrc ~/
ln -s ~/.dotfiles/.vimrc ~/
# install oh-my-zsh
if [ ! -e "/Users/$(whoami)/.oh-my-zsh/" ]
then
    sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi
# install Vundle
if [ ! -e " ~/.vim/bundle/Vundle.vim" ]
then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
# install vim pluigns
vim -es -c "PluginInstall" -c "q" -c "q" 
rm -rf ~/.vim/colors
ln -s ~/.vim/bundle/vim-colorschemes/colors ~/.vim/colors
