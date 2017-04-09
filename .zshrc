
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
)
export MANPATH=${(j/:/)man_path}

info_path=(
    ${HOME}/.linuxbrew/share/info
)
export INFOPATH=${(j/:/)info_path}

# load ohmyzsh
. ~/.ohmyzshrc
# Load non-public zshrc
test -f ~/.zshrc.local && . ~/.zshrc.local
# load iterm intergration (if it exists)
test -e ~/.iterm2_shell_integration.zsh && . ~/.iterm2_shell_integration.zsh
# load exports
. ~/.zshrc.exports
# load functions
. ~/.zshrc.functions
# source alias file
. ~/.zshrc.alias

# Set left justified prompt
PROMPT='${ret_status} %{$fg[cyan]%}%c%{$reset_color%}$(git_super_status) '
# Set the right justified prompt
# RPROMPT='%{$fg[blue]%}$(localip)%{$reset_color%}'





