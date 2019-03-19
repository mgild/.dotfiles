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
    ${HOME}/{,.}local/bin
    ${HOME}/.local/diff-so-fancy
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
    ${HOME}/.zshrc.exports
    ${HOME}/.zshrc.functions
    ${HOME}/.zshrc.alias
    ${HOME}/.zshrc.fzf
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
export EDITOR=vim
export VISUAL=vim

# zsh fix for tab completion lag in google3
zstyle ':completion:*' users root $USER
source $HOME/.cargo/env
