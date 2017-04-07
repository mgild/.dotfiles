
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

# load exports
. ${HOME}/.zshrc.exports
# load functions
. ${HOME}/.zshrc.functions
# load ohmyzsh
. ${HOME}/.ohmyzshrc
# load iterm intergration (if it exists)
test -e "${HOME}/.iterm2_shell_integration.zsh" && . "${HOME}/.iterm2_shell_integration.zsh"
# Load non-public zshrc
test -f ~/.zshrc.local && source ~/.zshrc.local
# source alias file
source ~/.zshrc.alias

# Set left justified prompt
PROMPT='${ret_status} %{$fg[cyan]%}%c%{$reset_color%}$(git_super_status) '
# Set the right justified prompt
# RPROMPT='%{$fg[blue]%}$(localip)%{$reset_color%}'





