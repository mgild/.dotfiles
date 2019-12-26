# Symlink the vimrc
ln -sfn $CWD/src_files/.vimrc ~/

# install Vundle
if [[ ! -a "${HOME}/.vim/plugged" ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
# install vim pluigns
vim -E -c "PluginInstall" -c "qa" || true
# Remove old colors and symlink the theme bundle
mv ~/.vim/colors  ~/.vim/colors.old || true
ln -s ~/.vim/bundle/vim-colorschemes/colors ~/.vim/colors || true

# Download and build YouCompleteMe compiler
# if [[ ! -a ${HOME}/.vim/bundle/youcompleteme/third_party/ycmd/ycm_core.so ]]; then
    # python ~/.vim/bundle/youcompleteme/install.py --clang-completer --tern-completer
# fi


