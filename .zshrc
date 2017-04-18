
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
    s="$@";
    RPL=$(($(tput cols)-$(num_visible "$(print -P $RPROMPT)")));
    del_length=$(min "$TRPROMPTPOS" "$RPL");
    TRPROMPTPOS=$(($(tput cols)-$(num_visible "$(print -P $s)")));
    out=$(print -Pn $s)
    fill=$((TRPROMPTPOS - del_length));
    filler=""
    for ((i = 0; i < fill; i++)); do
        filler=$filler" ";
    done
    cursor_pos=$(min $del_length $TRPROMPTPOS);
    tput sc;
    tput civis;
    tput cup 0 $cursor_pos;
    echo -n $filler$out;
    tput rc;
    tput cnorm;
}


TRPROMPT='%B%F{39}[%D{%L:%M:%S}]$(print -rnD $PWD)%f%b'

# zsh builitn defining what to do before prompt load
precmd() { load_TR_prompt "$TRPROMPT"; }
# Set left justified prompt
export C;
PROMPT='${ret_status}%F{12}%c%b%F{7}$(git_super_status)%F{$C} $%f '
#RPROMPT='%B%F{12}$(date +%r)%b%f'
#export PS1='$(junk sss) '
#Allow prompt substitution
setopt PROMPT_SUBST
TMOUT=1

TRAPALRM() {
    ((C=((C+1) % 124) + 88));
    zle reset-prompt; #add that github thing
    precmd "$TRPROMPT";
}





