setopt extended_glob
set -gh

# Path extensions
path=(
    # X11
    /opt/X11/bin
    # user builds
    ${HOME}/{,.}local/bin
    ${HOME}/local/solana-release/bin
    ${HOME}/.local/diff-so-fancy
    # gems
    ${HOME}/.ruby/bin
    # default paths
    ${HOME}/go/bin
    /usr/local
    /{usr/,}{local/,}{s,}bin
    # games
    /usr/games
    # cargo bin
    ${HOME}/.cargo/bin
    ${HOME}/local/google-cloud-sdk/bin
    /usr/local/opt/python@3.8/bin
    $HOME/.nodebrew/current/bin
    /Users/mgild/.local/share/solana/install/active_release/bin
)
# Join path and export
export PATH=${(j/:/)path}

man_path=(
    /usr/local/opt/coreutils/libexec/gnuman
    /usr/local/share/man
    /usr/share/man
)
export MANPATH=${(j/:/)man_path}

info_path=(
    /home/linuxbrew/.linuxbrew/share/info
    ${HOME}/.linuxbrew/share/info
)
export INFOPATH=${(j/:/)info_path}

srcs=(
    ${HOME}/.ohmyzshrc
    ${HOME}/.zshrc.local
    # ${HOME}/.iterm2_shell_integration.zsh
    ${HOME}/.zshrc.functions
    ${HOME}/.zshrc.alias
    ${HOME}/.zshrc.exports
)

for f in $srcs; test -e "$f" && . "$f"

export C;
precmd() {
    C=$(( RANDOM % 232 ))
}

ret_status="%B%(?:%F{6}:%F{1})➜%f%b"
PROMPT='%F{209}%B%f%b${ret_status} %F{13}%B%C%b%f %F{$C}$%f '

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
umask 022
# alias vi=nvim
# alias vim=nvim
export EDITOR=vim
export VISUAL=vim
export DISPLAY=vim
export P4PORT=perforce:1666
export P4DIFF="/usr/bin/diff -u"
# export P4MERGE=' vim -f $1 $3 $2 $4 -c "SpliceInit"'
# zsh fix for tab completion lag in google3
zstyle ':completion:*' users root $USER
# zstyle ":completion:*:git-checkout:*" sort false
# zstyle ':completion:*:descriptions' format '[%d]'
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
export GCLOUD_PROJ="mgild-test-proj-1"
export PROJECT_ID="mgild-test-proj-1"

mkcd() {
  mkdir -p "$1"; cd "$1"
}
export REGION="us-central1"
export GOOGLE_ORG_ID="433637338589"

# # The next line updates PATH for the Google Cloud SDK.
# if [ -f '/usr/local/google/home/mgild/.local/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/google/home/mgild/.local/google-cloud-sdk/path.zsh.inc'; fi
#
# # The next line enables shell command completion for gcloud.
# if [ -f '/usr/local/google/home/mgild/.local/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/google/home/mgild/.local/google-cloud-sdk/completion.zsh.inc'; fi
alias python=python3
alias pip=pip3
# alias node=/usr/local/opt/node@10/bin/node
remix_dir() { remixd -s $PWD --remix-ide https://remix.ethereum.org }
# alias vim=nvim
# alias npm=/usr/local/Cellar/node@10/10.23.0/bin/npm
# alias node=/usr/local/Cellar/node@10/10.23.0/bin/node
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
alias '$'=''
alias readlink=greadlink
# export LIVE=1
# export CLUSTER=devnet
alias '$'=';'
