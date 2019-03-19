DIR="$1"
cd "$DIR"
VCS_INFO="$(print -Pn $(zsh -c "\
  . ~/.zshrc;\
  . ~/.oh-my-zsh/custom/plugins/zsh-git-prompt/zshrc.sh;\
  vcs_info -Pn | sed 's/\x1B\[[0-9;]\+[A-Za-z]//g'\
"))"
print -Pn "${VCS_INFO}"
