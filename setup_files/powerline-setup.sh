# setup powerline
is_pipped(){pip freeze | awk -F= '{print $1}' | grep "^$1$" &> /dev/null;}
if ! is_pipped powerline-status; then
    pip install --user powerline-status
fi
POWERLINE_ROOT="$(pip show powerline-status | grep '^Location: ' | sed 's/^Location: //')/powerline"
ln -sfn "$POWERLINE_ROOT/bindings/tmux/powerline.conf" "${HOME}"

# install powerline fonts
if [[ ! -d ${HOME}/.powerline_fonts ]]; then
    git clone https://github.com/powerline/fonts.git ~/.powerline_fonts
    bash ${HOME}/.powerline_fonts/install.sh
fi
