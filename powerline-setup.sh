# setup powerline
is_pipped(){pip freeze | awk -F= '{print $1}' | grep "^$1$" &> /dev/null;}
if ! is_pipped powerline-status; then
    pip install --user powerline-status
fi
if ! is_pipped powerline-mem-segment; then
    pip install --global-option=build_ext --global-option="-I/home/${USER}/python-dev/include/python2.7" --user powerline-mem-segment
fi
if ! is_pipped netifaces; then
    pip install --global-option=build_ext --global-option="-I/home/${USER}/python-dev/include/python2.7" --user netifaces
fi
POWERLINE_ROOT="$(pip show powerline-status | grep '^Location: ' | sed 's/^Location: //')/powerline"
powerline_config="$POWERLINE_ROOT/config_files"
if [ ! -L $powerline_config ]; then
    mv $powerline_config $powerline_config.old
fi
ln -sfn "$CWD/powerline_config" "$powerline_config"
ln -sfn "$POWERLINE_ROOT/bindings/tmux/powerline.conf" "${HOME}"

# install powerline fonts
if [[ ! -d ${HOME}/.powerline_fonts ]]; then
    git clone https://github.com/powerline/fonts.git ~/.powerline_fonts
    bash ${HOME}/.powerline_fonts/install.sh
fi
