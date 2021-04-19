setopt extended_glob
set -gh

# Path extensions
path=(
    # X11
    /opt/X11/bin
    # user builds
    ${HOME}/{,.}local/bin
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
PROMPT='$(is_javatest_dir && echo "(javatest) ")%F{209}%B%f%b${ret_status} %F{13}%B%C%b%f %F{$C}$%f '

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
umask 022
export EDITOR=vim
export VISUAL=vim
export DISPLAY=vim
export P4PORT=perforce:1666
export P4DIFF="/usr/bin/diff -u"
# export P4MERGE=' vim -f $1 $3 $2 $4 -c "SpliceInit"'
# zsh fix for tab completion lag in google3
zstyle ':completion:*' users root $USER
alias copybara='/google/data/ro/teams/copybara/copybara'
alias pastebin="/google/src/head/depot/eng/tools/pastebin"
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
alias tm=/google/data/ro/teams/tenantmanager/tools/tm
alias '$'=';'
