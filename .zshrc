
# Path extensions
path=(
    # python 2.7 user bin on osx
    ${HOME}/Library/Python/2.7/bin
    # Latex tools (osx)
    /Library/TeX/texbin
    # X11
    /opt/X11/bin
    # user builds
    ${HOME}/{.,}local/bin
    # Homebrew packages
    /usr/local/opt{/coreutils/libexec/gnubin,}
    # default paths
    /{usr/,}{local/,}{s,}bin
)
# Join path and export
export PATH=${(j/:/)path}
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

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





