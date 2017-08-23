
# Path extensions
path=(
    # Linuxbrew
    ${HOME}/.linuxbrew/bin
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
)
# Join path and export
export PATH=${(j/:/)path}

man_path=(
    ${HOME}/.linuxbrew/bin
    /usr/local/opt/coreutils/libexec/gnuman
    /usr/{local/,}share/man
)
export MANPATH=${(j/:/)man_path}

info_path=(
    ${HOME}/.linuxbrew/share/info
)
export INFOPATH=${(j/:/)info_path}

srcs=(
    ~/.ohmyzshrc
    ~/.zshrc.local
    ~/.iterm2_shell_integration.zsh
    ~/.zshrc.exports
    ~/.zshrc.functions
    ~/.zshrc.alias
    #~/.dotfiles/zsh-trprompt/trprompt.zsh
)

for f in $srcs; test -e $f && . $f

export C;
precmd() {
    ((C=((C+1) % 124) + 88));
}

PROMPT='${ret_status}%F{12}%c%b%F{7}$(git_super_status)%F{$C} $%f '
#RPROMPT='%B%F{39}[%D{%L:%M:%S}] | $(print -rnD $PWD)%f%b';

# setopt PROMPT_SUBST;
# TMOUT=1;
# TRAPALRM() {
    # precmd;
    # zle reset-prompt;
# }
#



[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
