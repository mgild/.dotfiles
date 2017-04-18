
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


cursor_coord(){
    bash -c 'exec < /dev/tty;oldstty=$(stty -g);stty raw -echo min 0;echo -en "\033[6n" > /dev/tty;IFS=; read -r -d R -a pos;stty $oldstty;echo $pos;'
}

_newline=$'\n'
_lineup=$'\e[1A'
_linedown=$'\e[1B'
load_TRPROMPT(){
    new_prompt=$(print -P "$@");
    new_len=$(num_visible "$new_prompt");
    fill=$((old_len - new_len));
    old_len=$new_len;
    res='';
    filler=''
    for ((i=0; i < fill; ++i)) {
        filler="$filler ";
    }
    h=($(bash ~/pos.sh | split ' ')) #$(tput lines);
    for ((i=0; i < h[1]; ++i)) {
        res="${res}%{${_lineup}%}";
    }
    res="${res}${filler}${@}";
    for ((i=0; i < h[1]; ++i)) {
        res="${res}%{${_linedown}%}";
    }
    echo -n $res
}


export TRPROMPTPOS=$(tput cols)

TRPROMPT() {
    echo -n "%B%F{39}[%D{%L:%M:%S}] | $(print -rnD $PWD)%f%b"
}

# zsh builitn defining what to do before prompt load
precmd() {
    ((C=((C+1) % 124) + 88));
    # load_TR_prompt;
}
# Set left justified prompt
export C;
PROMPT='${ret_status}%F{12}%c%b%F{7}$(git_super_status)%F{$C} $%f '
RPROMPT='$(load_TRPROMPT "$(TRPROMPT)")'
#export PS1='$(junk sss) '
#Allow prompt substitution
setopt PROMPT_SUBST
TMOUT=1

TRAPALRM() {
    zle reset-prompt; #add that github thing
}





