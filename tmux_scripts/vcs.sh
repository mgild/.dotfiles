DIR="$1"
cd "$DIR"
REPO_NAME="$(basename $(git --no-optional-locks rev-parse --show-toplevel 2> /dev/null) 2> /dev/null)"
if [[ $TMUX_PLUGIN_VCS_DISABLE == 1 ]]; then
  return
fi
export TMUX_PLUGIN_VCS_DISABLE=1;
VCS_INFO="$(print -Pn $(zsh -c "\
  . /Users/mgild/.oh-my-zsh/custom/plugins/zsh-git-prompt/zshrc.sh;\
  git_super_status | sed 's/\x1B\[[0-9;]\+[A-Za-z]//g'\
  | perl -ple 's/\e\[\d+(;\d+)*m//g'\
"))"
res="${REPO_NAME}${VCS_INFO}"
if [[ ${#res} != 0 ]]; then
  print "$res"
fi
