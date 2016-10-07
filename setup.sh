#! /bin/zsh
CWD="$(cd -P -- "$(dirname -- "$0")" && pwd -P)" 

.  $CWD/moveSrcs.sh

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
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed "s/env zsh//g")"
    # Remove the newly created zshrc
    rm ~/.zshrc
fi
# link zshrc
ln -s $CWD/.zshrc ~/
# Do the initial installs in zshrc
source  ~/.zshrc
if [[ ! -a ${HOME}/.vim/bundle/YouCompleteMe/third_party/ycmd/ycm_core.so ]]
then
    # Finish YouCompleteMe install
    python2 ~/.vim/bundle/youcompleteme/install.py --clang-completer
fi


