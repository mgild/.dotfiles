
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
    s="$TRPROMPT";
    del_length="$TRPROMPTPOS";
    out=$(print -Pn $s);
    TRPROMPTPOS=$(($(tput cols)-$(num_visible "$out")));
    fill=$((TRPROMPTPOS - del_length));
    #echo $del_length $TRPROMPTPOS $(tput cols)
    filler="";
    for ((i = 0; i < fill; i++)); do
        filler=$filler" ";
    done
    civis=$(tput civis);
    cnorm=$(tput cnorm);
    cnewpos=$(tput cup 0 $(min $del_length $TRPROMPTPOS));
    sc=$(tput sc);
    rc=$(tput rc)
    assembled="$sc$civis$cnewpos$filler$out$cnorm$rc";
    # single echo statement. Make as fast as possible
    echo -n $assembled;
}


TRPROMPT='%B%F{39}[%D{%L:%M:%S}] | $(print -rnD $PWD)%f%b'

# zsh builitn defining what to do before prompt load
precmd() {
    ((C=((C+1) % 124) + 88));
    load_TR_prompt
}
# Set left justified prompt
export C;
PROMPT='${ret_status}%F{12}%c%b%F{7}$(git_super_status)%F{$C} $%f '
#RPROMPT='%B%F{12}$(date +%r)%b%f'
#export PS1='$(junk sss) '
#Allow prompt substitution
setopt PROMPT_SUBST
TMOUT=1

TRAPALRM() {
    precmd;
    if [[ $WIDGET != *"complete"* && $WIDGET != *"beginning-search" ]]; then;
        zle reset-prompt;
    fi
}





