
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

# No longer needed. switched to mucomplete
# Download and build YouCompleteMe compiler
# if [[ ! -a ${HOME}/.vim/bundle/youcompleteme/third_party/ycmd/ycm_core.so ]]; then
    # python ~/.vim/bundle/youcompleteme/install.py --clang-completer --tern-completer
# fi


