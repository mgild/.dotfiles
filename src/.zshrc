setopt extended_glob
set -gh

# Path extensions
path=(
    # cors_sdk tools
    ~/depot_tools
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
    # Linuxbrew
    {/home/linuxbrew,${HOME}}/.linuxbrew/bin
    # custom python build path from dotfiles script
    ${HOME}/python-dev/bin
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
    ~/.ohmyzshrc
    ~/.zshrc.local
    ~/.iterm2_shell_integration.zsh
    ~/.zshrc.exports
    ~/.zshrc.functions
    ~/.zshrc.alias
)

for f in $srcs; test -e $f && . $f

export C;
precmd() {
    ((C=((C+1) % 124) + 88));
}


function g4_prompt_info() {
    local working_dir=`pwd`
    local g4client=`g4 set P4CLIENT | awk -F: '{print $2}'`
    if [[ ${#g4client} -ne 0 ]]; then
        echo "(%B%F{6}g4:%F{26}${g4client}%b%f)"
        return 0
    fi
    return 1
}

vcs_info() {
    g4info=$(g4_prompt_info)
    if [[ $? -eq 0 ]]; then
        echo $g4info
    elif [[ $GIT_BRANCH != ":" ]]; then
        git_super_status
    fi
}

local ret_status="%B%(?:%F{6}:%F{1})➜%f%b"
PROMPT='${ret_status} %F{13}%B%C%b%f$(vcs_info) %F{$C}$%f '

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source /etc/bash_completion.d/g4d

