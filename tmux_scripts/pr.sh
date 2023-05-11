DIR="$1"
cd "$DIR"
source ~/.zshrc.local
# git --no-optional-locks rev-parse --show-toplevel > /dev/null 2>&1 || return
gh pr list 2>&1 | wc -l | sed 's/[[:space:]]//g'
