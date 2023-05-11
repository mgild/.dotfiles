DIR="$1"
echo "${DIR/$HOME/~}" | sed -E "s;/google/src/cloud/$USER/([^/]*)/;http://cs/;" | sed 's;Library/Group Containers/G69SCX94XU.duck/Library/Application Support/duck/Volumes;mounts;'
