DIR="$1"
echo "${DIR/$HOME/~}" | sed -E "s;/google/src/cloud/$USER/([^/]*)/;http://cs/;"
