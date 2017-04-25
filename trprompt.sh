function min() {
    ((($1 < $2)) && echo $1) || echo $2;
}

# Get number of visible characters in a string
function num_visible(){
    t=$(echo "$1" | perl -pe 's/\x1b\[[^m]+m//g');
    echo ${#t};
}

function TRPROMPT_f(){print -Pn "$TRPROMPT";}

function load_TRPROMPT () {
    s="$(TRPROMPT_f)";
    out=$(print -Pn $s);
    fill=$((TRPROMPTPOS - OLDTRPROMPTPOS));
    # TODO: only add filler if you are on the last line (tput rows - rows = 0);
    filler="";
    for ((i = 0; i < fill; i++)); do
        filler=$filler" ";
    done
    civis=$(tput civis);
    cnorm=$(tput cnorm);
    cnewpos=$(tput cup 0 $(($(min $OLDTRPROMPTPOS $TRPROMPTPOS) - 1)));
    sc=$(tput sc);
    rc=$(tput rc);
    assembled="$sc$civis$cnewpos$filler$out$cnorm$rc";
    # single echo statement. Make as fast as possible
    exec < /dev/tty;
    echo -n $assembled > /dev/tty;
}

export TRPROMPTPOS=$(tput cols);
export OLDTRPROMPTPOS=$TRPROMPTPOS;

function TRPROMPT_hook(){
    OLDTRPROMPTPOS=$TRPROMPTPOS;
    TRPROMPTPOS=$(($(tput cols)-$(num_visible "$(print -Pn "$(TRPROMPT_f)")")));
    load_TRPROMPT;
}

setopt PROMPT_SUBST;
TMOUT=1;
TRAPALRM() {
   TRPROMPT_hook;
}

autoload -Uz add-zsh-hook;
add-zsh-hook precmd TRPROMPT_hook;
