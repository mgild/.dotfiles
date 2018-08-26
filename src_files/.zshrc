setopt extended_glob
set -gh

# Path extensions
path=(
    # cors_sdk tools
    ${HOME}/depot_tools
    # python 2.7 user bin on osx
    ${HOME}/Library/Python/2.7/bin
    # Latex tools (osx)
    /Library/TeX/texbin
    # X11
    /opt/X11/bin
    # user builds
    ${HOME}/{.,}local/bin
    # Homebrew packages, go executables, gnu bin
    /usr/local/opt{/go/libexec/bin,/coreutils/libexec/gnubin,}
    # default paths
    /{usr/,}{local/,}{s,}bin
    # custom python build path from dotfiles script
    ${HOME}/python-dev/bin
    # games
    /usr/games
)
# Join path and export
export PATH=${(j/:/)path}

man_path=(
    {/home/linuxbrew,${HOME}}/.linuxbrew/bin
    /usr/local/opt/coreutils/libexec/gnuman
    /usr/{local/,}share/man
)
export MANPATH=${(j/:/)man_path}

info_path=(
    {/home/linuxbrew,${HOME}}/.linuxbrew/share/info
)
export INFOPATH=${(j/:/)info_path}

srcs=(
    ${HOME}/.ohmyzshrc
    ${HOME}/.zshrc.local
    ${HOME}/.iterm2_shell_integration.zsh
    ${HOME}/.zshrc.exports
    ${HOME}/.zshrc.functions
    ${HOME}/.zshrc.alias
)

for f in $srcs; test -e $f && . $f

export C;
precmd() {
    ((C=((C+1) % 124) + 88));
}

# get a status on default changelist like "+1~3-2".
p4_pending_status() {
  local changed=0
  local added=0
  local deleted=0
  for opened in $(p4 opened 2&> /dev/null | awk -F " - " '{print $2}' | awk '{print $1}'); do
      if [[ $opened == "edit" ]];then
          (( changed+=1 ))
      elif [[ $opened == "add" ]];then
          (( added+=1 ))
      elif [[ $opened == "delete" ]];then
          (( deleted+=1 ))
      fi
  done
  [[ $added > 0 ]] && echo -n "%F{34}+$added%f"
  [[ $changed > 0 ]] && echo -n "%F{142}~$changed%f"
  [[ $deleted > 0 ]] && echo -n "%F{124}-$deleted%f"
}

p4_prompt_info() {
    # if first param specified, cd to that directory before p4 info taken
    if [[ ${#1} -ne 0 ]]; then
      cd "$1"
    fi
    which p4 &> /dev/null || return 1
    local p4client=$(pwd | awk -F/ '{print $6}')
    if [[ ${#p4client} -ne 0 ]]; then
        local st="$(p4_pending_status)"
        local sep=""
        [[ ${#st} -ne 0 ]] && sep="|"
        echo "(%B%F{6}g4:%F{26}${p4client}%f${sep}${st}%b)"
        return 0
    fi
    return 1
}

git_super_duper_status() {
    [[ "$GIT_BRANCH" != ":" ]] && git_super_status
}

vcs_info() {
    git_super_duper_status
}

ret_status="%B%(?:%F{6}:%F{1})➜%f%b"
PROMPT='%F{209}%B%f%b${ret_status} %F{13}%B%C%b%f$(vcs_info) %F{$C}$%f '

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export TRPROMPT='%K{93}%F{233}$(date)%f%k'

export DISABLE_AUTO_TITLE="true"

