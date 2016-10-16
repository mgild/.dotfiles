# Moves file $1 to $2, deletes if file is a symlink
function mvFile() {
    if [[ -f $1 ]]
    then
        if [[ -L $1 ]]
        then
            rm $1
        else
            mv $1 $2
        fi
    fi
}

mvFile ~/.zshrc ~/.zshrc.local
mvFile  ~/.vimrc ~/.vimrc.local
