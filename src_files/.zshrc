# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && . "$HOME/.fig/shell/zshrc.pre.zsh"
setopt extended_glob
set -gh

# Path extensions
path=(
    /Users/mgild/.local/share/solana/install/active_release/bin
    # X11
    /opt/X11/bin
    # user builds
    ${HOME}/{,.}local/bin
    # ${HOME}/local/solana-release/bin
    ${HOME}/.local/diff-so-fancy
    # gems
    ${HOME}/.ruby/bin
    # default paths
    ${HOME}/go/bin
    /usr/local
    /{usr/,}{local/,}{s,}bin
    # games
    /usr/games
    # cargo bin
    ${HOME}/.cargo/bin
    ${HOME}/local/google-cloud-sdk/bin
    /usr/local/opt/python@3.8/bin
    $HOME/.nodebrew/current/bin
)
# Join path and export
export PATH=${(j/:/)path}

man_path=(
    /usr/local/opt/coreutils/libexec/gnuman
    /usr/local/share/man
    /usr/share/man
)
export MANPATH=${(j/:/)man_path}

info_path=(
    /home/linuxbrew/.linuxbrew/share/info
    ${HOME}/.linuxbrew/share/info
)
export INFOPATH=${(j/:/)info_path}

srcs=(
    ${HOME}/.ohmyzshrc
    ${HOME}/.zshrc.local
    # ${HOME}/.iterm2_shell_integration.zsh
    ${HOME}/.zshrc.functions
    ${HOME}/.zshrc.alias
    ${HOME}/.zshrc.exports
)

for f in $srcs; test -e "$f" && . "$f"

export C;
precmd() {
    C=$(( RANDOM % 232 ))
}

ret_status="%B%(?:%F{6}:%F{1})➜%f%b"
PROMPT='%F{209}%B%f%b${ret_status} %F{13}%B%C%b%f %F{$C}$%f '

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
umask 022
# alias vi=nvim
# alias vim=nvim
export EDITOR=vim
export VISUAL=vim
export DISPLAY=vim
export P4PORT=perforce:1666
export P4DIFF="/usr/bin/diff -u"
# export P4MERGE=' vim -f $1 $3 $2 $4 -c "SpliceInit"'
# zsh fix for tab completion lag in google3
zstyle ':completion:*' users root $USER
# zstyle ":completion:*:git-checkout:*" sort false
# zstyle ':completion:*:descriptions' format '[%d]'
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
export GCLOUD_PROJ="mgild-test-proj-1"
export PROJECT_ID="mgild-test-proj-1"

mkcd() {
  mkdir -p "$1"; cd "$1"
}
export REGION="us-central1"
export GOOGLE_ORG_ID="433637338589"

# # The next line updates PATH for the Google Cloud SDK.
# if [ -f '/usr/local/google/home/mgild/.local/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/google/home/mgild/.local/google-cloud-sdk/path.zsh.inc'; fi
#
# # The next line enables shell command completion for gcloud.
# if [ -f '/usr/local/google/home/mgild/.local/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/google/home/mgild/.local/google-cloud-sdk/completion.zsh.inc'; fi
alias python=python3
alias pip=pip3
# alias node=/usr/local/opt/node@10/bin/node
remix_dir() { remixd -s $PWD --remix-ide https://remix.ethereum.org }
# alias vim=nvim
# alias npm=/usr/local/Cellar/node@10/10.23.0/bin/npm
# alias node=/usr/local/Cellar/node@10/10.23.0/bin/node
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
alias '$'=''
alias readlink=greadlink
# export LIVE=1
# export CLUSTER=devnet
alias '$'=';'
alias vim=nvim
sol_env2() {
    cd ~/projects/switchboard-core;
    bash set_environment2.sh $1;
    if [[ "$1" == "devnet" ]]; then
        export LIVE=1;
        export CLUSTER=devnet
        export RPC_URL="https://switchboard.devnet.rpcpool.com/f9fe774d81ba4527a418f5b19477"
    elif [[ "$1" == "mainnet" ]]; then
        export LIVE=1;
        export CLUSTER=mainnet
        export RPC_URL="https://switchboard.rpcpool.com/ec20ad2831092cfcef66d677539a"
    fi
    back;
}
sol_env() {
    cd ~/projects/switchboard-core;
    bash set_environment.sh $1;
    if [[ "$1" == "devnet" ]]; then
        export LIVE=1;
        export CLUSTER=devnet
        export RPC_URL="https://switchboard.devnet.rpcpool.com/f9fe774d81ba4527a418f5b19477"
    fi
    if [[ "$1" == "mainnet" ]]; then
        export LIVE=1;
        export CLUSTER=mainnet
        export RPC_URL="https://switchboard.rpcpool.com/ec20ad2831092cfcef66d677539a"
    fi
    back;
}
source ~/.zshrc.local
function agr { ag -0 -l "$1" | AGR_FROM="$1" AGR_TO="$2" xargs -0 perl -pi -e 's/$ENV{AGR_FROM}/$ENV{AGR_TO}/g'; }
push_oracle_v2() {
    DOCKER_BUILDKIT=1 docker build -t switchboardlabs/node:${1?} ~/projects/switchboard-oracle-v2;
    docker push switchboardlabs/node:${1?};
    docker pull switchboardlabs/node:${1?};
}
push_oracle() {
    docker build -t switchboardlabs/node:${1?} ~/projects/switchboard-oracle;
    docker push switchboardlabs/node:${1?};
    docker pull switchboardlabs/node:${1?};
}
export OPENSSL_DIR=/usr/local/Cellar/openssl@1.1/1.1.1k/
klogs() {
    if [[ "$1" == "" ]]; then
        kubectl logs -f -l app=oracle --all-containers --max-log-requests=50 --prefix=true
        return
    fi
    kubectl logs $(kubectl get pods | grep "${1}" | awk '{print $1 }' | head -1) --tail=1 -f
}
# export LIVE=1; export CLUSTER=devnet
# export RPC_URL="https://switchboard.devnet.rpcpool.com/f9fe774d81ba4527a418f5b19477"
pr_fresh() {
    rm /tmp/tmux_pr_widget/pr_*
}
push_crank () {
    docker build -t switchboardlabs/crank-turn:${1?} ~/projects/v2-setup
    docker push switchboardlabs/crank-turn:${1?}
    docker pull switchboardlabs/crank-turn:${1?}
}
link_example() {
    echo '\x1B]8;;file:///path/to/help/file\x1B\\the help file\x1B]8;;\x1B\\'
}
alias watch="watch -n .5"
alias ":qa"="tmux kill-pane"
per_min() {
    hash="$(echo "${PWD}:${@}" | sha256sum | awk '{print $1}')"
    mkdir -p /tmp/tmux_schedule/
    if [[ ! -f "/tmp/tmux_schedule/${hash}" ]]; then;
        eval "$*" > "/tmp/tmux_schedule/${hash}"
    fi
    cat "/tmp/tmux_schedule/${hash}"
}
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
alias lg=lazygit
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
export HISTORY_SUBSTRING_SEARCH_PREFIXED=1
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
export RPROMPT=""

# source /Users/mgild/.config/broot/launcher/bash/br

# Fig post block. Keep at the bottom of this file.
# [[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && . "$HOME/.fig/shell/zshrc.post.zsh"
alias kubectl="/Users/mgild/local/google-cloud-sdk/bin/kubectl"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# bun completions
[ -s "/Users/mgild/.bun/_bun" ] && source "/Users/mgild/.bun/_bun"

# bun
export BUN_INSTALL="/Users/mgild/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
alias ts0x="0x -- node -r ts-node/register -r tsconfig-paths/register"
alias ttt="tee $(tty)"
alias near_build="RUSTFLAGS='-C link-arg=-s' cargo build --target wasm32-unknown-unknown --release"
export OPENSSL_DIR=/usr/local/Cellar/openssl@1.1/1.1.1s/
export LIBRARY_PATH=$LIBRARY_PATH:/opt/homebrew/lib
export INCLUDE_PATH=$INCLUDE_PATH:/opt/homebrew/include:/usr/local/include
export CFLAGS="-I/usr/local/include -L/usr/local/lib $CFLAGS"
export STARKNET_NETWORK=alpha-goerli
export STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount
unix2date() {
    date -r "$1"
}
# ssh_mount() {
    # MOUNT_DIR="/Users/${USER}/mounts/azure_sgx"
    # IP="20.117.182.57"
    # IDENTITY_FILE="${HOME}/azure_pems/sgx2_key4.pem"
    # # sudo umount -f ${MOUNT_DIR}
    # # sudo diskutil unmount force ${MOUNT_DIR}
    # cd /Users/${USER}
    # # mkdir -p ${MOUNT_DIR}
    # df | grep ${MOUNT_DIR} >/dev/null
    # E1=$?
    # # ls ${MOUNT_DIR} 2>&1 >/dev/null
    # # E2=$?
    # if [[ $E1 == 0 ]]; then
        # cd ${MOUNT_DIR}
        # return
    # fi
    # # if [[ $E1 == 0 ]]; then
        # # diskutil unmount force ${MOUNT_DIR}
    # # fi
    # kill -9 $(ps aux | grep sshfs | grep -v grep | awk '{print $2}') 2>/dev/null
    # sshfs -C \
      # -o IdentityFile="${IDENTITY_FILE}" \
      # -o cache=yes \
      # -o compression=yes \
      # -o ServerAliveInterval=5 \
      # -o TCPKeepAlive=yes \
      # -o ServerAliveCountMax=2 \
      # -o max_readahead=100k \
      # -o intr \
      # ${USER}@${IP}:/home/${USER} ${MOUNT_DIR}
    # cd ${MOUNT_DIR}
# }
force_umount() {
    df | grep duck | awk -F "   " '{print $NF}' | while read x; do
        diskutil unmount force "$x";
    done
}
eval "$(/opt/homebrew/bin/brew shellenv)"
export DOCKER_BUILDKIT=1
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
