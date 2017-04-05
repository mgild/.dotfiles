#! /bin/zsh
# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$ZSH/custom

function assertInstalled() {
    local success=true
    for var in "$@"; do
        if ! which $var &> /dev/null; then
            echo "Install $var!"
            success=false
        fi
    done
    $success || exit 1
}

assertInstalled zsh vim wget python pip git cmake ctags tmux
CWD="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

if test "$(uname -s)" = "Darwin"; then
    . $CWD/osxsetup.sh
fi


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

# Ensure custom zsh plugins are downloaded
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
ln -s $CWD/.ohmyzshrc ~/
# link tmux conf
ln -s "$CWD/.tmux.conf" "${HOME}"

# setup powerline
is_pipped(){pip freeze | awk -F= '{print $1}' | grep "^$1$" &> /dev/null;}
if ! is_pipped powerline-status; then
    pip install --user git+git://github.com/Lokaltog/powerline
fi
if ! is_pipped powerline-mem-segment; then
    pip install --user powerline-mem-segment
fi
if ! is_pipped netifaces; then
    pip install --user netifaces
fi
POWERLINE_ROOT="$(pip show powerline-status | grep '^Location: ' | sed 's/^Location: //')/powerline"
powerline_config="$POWERLINE_ROOT/config_files"
if [ ! -L $powerline_config ]; then
    mv $powerline_config $powerline_config.old
fi
ln -s "$CWD/powerline_config" "$powerline_config"
ln -s "$POWERLINE_ROOT/bindings/tmux/powerline.conf" "${HOME}"

# install powerline fonts
if [[ ! -d ${HOME}/.powerline_fonts ]]; then
    git clone https://github.com/powerline/fonts.git ~/.powerline_fonts
    bash ${HOME}/.powerline_fonts/install.sh
fi

# Download and build YouCompleteMe compiler
if [[ ! -a ${HOME}/.vim/bundle/youcompleteme/third_party/ycmd/ycm_core.so ]]; then
    python ~/.vim/bundle/youcompleteme/install.py --all
fi


# Enter zsh shell
zsh

