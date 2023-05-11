for x in $(df | grep mounts | awk '{ print $1 ":" $NF }'); do
  D=$(echo $x | awk -F ':' '{ print $NF }')
  R=$(echo $x | awk -F ':' '{ print $1 }')
  if [[ "$1" == *$D* ]]; then
    echo $R
  fi
done

