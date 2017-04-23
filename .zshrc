
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

export TRPROMPTPOS=$(tput cols);
export OLDTRPROMPTPOS=$TRPROMPTPOS;
#ENV VARIABLE NOT MAINTAINED WHEN LOADING PROMPT. PASS IT IN how do i set?
load_TRPROMPT () {
    s="$(TRPROMPT)";
    out=$(print -Pn $s);
    row=$(get_cursor_row);
    if [[ $row == 1 ]]; then
        echo -n "$s";
    else
        fill=$((TRPROMPTPOS - OLDTRPROMPTPOS));
        #echo -n "---${fill}---";
        filler="";
        for ((i = 0; i < fill; i++)); do
            filler=$filler" ";
        done
        civis=$(tput civis);
        cnorm=$(tput cnorm);
        cnewpos=$(tput cup 0 $(($(min $OLDTRPROMPTPOS $TRPROMPTPOS) - 1)));
        sc=$(tput sc);
        rc=$(tput rc)
        assembled="$sc$civis$cnewpos$filler$out$cnorm$rc";
        # single echo statement. Make as fast as possible
        exec < /dev/tty;
        echo -n $assembled > /dev/tty;
    fi;
}


TRPROMPT(){echo -n "%B%F{39}[%D{%L:%M:%S}] | $(print -rnD $PWD)%f%b"}

# zsh builitn defining what to do before prompt load
precmd() {
    ((C=((C+1) % 124) + 88));
    OLDTRPROMPTPOS=$TRPROMPTPOS;
    TRPROMPTPOS=$(($(tput cols)-$(num_visible "$(print -Pn "$(TRPROMPT)")")));
    #echo $TRPROMPTPOS;
}
# Set left justified prompt
export C;
PROMPT='${ret_status}%F{12}%c%b%F{7}$(git_super_status)%F{$C} $%f '
# TODO: Make a LASTTRPROMPTPOS VARIABLE AND RE-EVALUATE BEFORE LOAD TRPROMTP
RPROMPT+='$(load_TRPROMPT)'
#Allow prompt substitution
setopt PROMPT_SUBST
TMOUT=1

TRAPALRM() {
    precmd;
    if [[ $WIDGET != *"complete"* && $WIDGET != *"beginning-search" ]]; then;
        zle reset-prompt;
    fi
}
#
get_cursor_row() {
    exec < /dev/tty;
    oldstty=$(stty -g);
    stty raw -echo min 0;
    tput u7 > /dev/tty;
    read -r -d R pos;
    stty $oldstty;
    echo ${pos:2} | sed -E 's/;.*//g';
}



