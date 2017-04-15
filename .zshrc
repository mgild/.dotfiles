
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
)

for f in $srcs; test -e $f && . $f


load_TR_prompt () {
    s=$(TRPROMPT)
    tput sc;
    tput cup 0 $PREVTRLEN;
    tput ed;
    tput cup 0 $(($(tput cols)-$(num_visible "$s")));
    PREVTRLEN=$(num_visible "$s");
    echo $s;
    tput rc;
}
TRPROMPT () {
    echo -e "\e[1;94m$(print -rD $PWD) | $(date +%r)\e[0m"
}

# zsh builitn defining what to do before prompt load
precmd() { load_TR_prompt; }
# Set left justified prompt
PROMPT='${ret_status} %{$fg[cyan]%}%c%{$reset_color%}$(git_super_status) '







