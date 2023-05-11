MOUNT="$(echo "$1" | grep -oE '.*Volumes\/([A-Za-z-]+)')"
if [[ ${#MOUNT} == 0 ]]; then
  return;
fi
df | grep "duck/Volumes" | grep "$MOUNT" | awk -F ":" '{print $1}'
