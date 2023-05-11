DIR="$1"
cd "$DIR"
ext="$(pwd | sed "s;^$(git rev-parse --show-toplevel);;")"
REPO_PATH="$(git --no-optional-locks config --get remote.origin.url \
  | sed -e 's/\.git$//g' \
  | sed -E 's;([^/]):;\1/;g' \
  | sed -e 's/git@/https:\/\//g' \
  | sed -e 's;///;://;g')"
res="${REPO_PATH}"
if [[ ${#res} != 0 ]]; then
  echo "${res}/tree/$(git branch --show)${ext}"
fi
