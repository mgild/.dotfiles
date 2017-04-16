
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

export TRPROMPTPOS=$(tput cols)
load_TR_prompt () {
    s="$@"
    tput civis;
    tput sc;
    tput cup 0 $TRPROMPTPOS;
    tput el;
    TRPROMPTPOS=$(($(tput cols)-$(num_visible "$(print -P $s)")));
    tput cup 0 $TRPROMPTPOS;
    print -P $s;
    tput rc;
    tput cnorm;
}


TRPROMPT='%B%F{39}$(print -rD $PWD) | $(date +%r)%f%b'

# zsh builitn defining what to do before prompt load
precmd() { load_TR_prompt "$TRPROMPT"; }
# Set left justified prompt
export C;
PROMPT='${ret_status}%F{39}%c%b%F{7}$(git_super_status)%F{$C} $%f '
#export PS1='$(junk sss) '
#Allow prompt substitution
setopt PROMPT_SUBST
TMOUT=1

TRAPALRM() {
    ((C=(C+1) % 232));
    zle reset-prompt;
}





