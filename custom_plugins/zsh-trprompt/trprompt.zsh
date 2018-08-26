# Get number of visible characters in a string
function num_visible() {
    t=$(echo "$1" | perl -pe 's/\x1b\[[^m]+m//g');
    echo ${#t};
}

function min() {
    ((($1 < $2)) && echo $1) || echo $2;
}

function TRPROMPT_f(){print -Pn "$TRPROMPT";}

function load_TRPROMPT () {
    s="$(TRPROMPT_f)";
    out=$(print -Pn $s);
    filler=$(perl -E "say ' ' x $((OLDTRPROMPTPOS - TRPROMPTPOS))")
    OLDTRPROMPTPOS=$TRPROMPTPOS;
    TRPROMPTPOS=$(($(tput cols) - $(num_visible "$out")))
    cnewpos=$(tput cup 0 $(min $TRPROMPTPOS $OLDTRPROMPTPOS));
    assembled="$(tput sc)$(tput civis)$cnewpos$filler$out$(tput cnorm)$(tput rc)";
    # single echo statement. Make as fast as possible
    echo -n $assembled
}

function TRPROMPT_hook(){
    while true; do
        TRPROMPTPOS=$(($(tput cols)-$(num_visible "$(print -Pn "$(TRPROMPT_f)")")));
        load_TRPROMPT;
        sleep 1;
    done
}

setopt PROMPT_SUBST;
TRPROMPTPOS=$(tput cols);
OLDTRPROMPTPOS=$TRPROMPTPOS;
