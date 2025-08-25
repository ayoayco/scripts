# Load config
. ${HOME}/ayo.conf

model=$coder
modelfile=$coder_modelfile

# Initialize variables
typora_flag=false
other_args=""

# Process arguments to handle -t flag and collect other args
while [[ $# -gt 0 ]]; do
  case $1 in
    -t)
      typora_flag=true
      shift
      ;;
    *)
      other_args="$other_args $1"
      shift
      ;;
  esac
done

# Set other_args to the first argument if it exists, otherwise empty string
if [[ -n "$other_args" ]]; then
  # Remove leading space
  other_args="${other_args# }"

  IFS=' ' read -ra args_array <<< "$other_args"
  if [[ ${#args_array[@]} -gt 1 ]]; then
    # Remove first element and rejoin remaining elements
    other_args="${args_array[*]:1}"
  else
    # If there's only one argument, set other_args to empty string
    other_args=""
  fi
fi


if ! [ "$other_args" = "" ]; then
  if [ "$other_args" = "sleep" ]; then
    ollama stop $model
  elif [ "$other_args" = "init" ]; then
    ollama create "$model" -f "$modelfile"
  else
    tempfile="$(mktemp)"
    ollama run $model "$other_args" --hidethinking > $tempfile
    typora $tempfile
  fi
else
  ollama run $model --hidethinking
fi
