DIR="$1"
cd "$DIR"
REPO_NAME="$(basename $(git --no-optional-locks rev-parse --show-toplevel 2> /dev/null) 2> /dev/null)"
VCS_INFO="$(print -Pn $(zsh -c "\
  . ~/.zshrc;\
  . ~/.oh-my-zsh/custom/plugins/zsh-git-prompt/zshrc.sh;\
  vcs_info | sed 's/\x1B\[[0-9;]\+[A-Za-z]//g'\
"))"
res="${REPO_NAME}${VCS_INFO}"
if [[ ${#res} != 0 ]]; then
  print "$res"
else
  echo '--'
fi
