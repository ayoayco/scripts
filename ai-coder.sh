# Load config
. ${HOME}/ayo.conf

model=$coder

if ! [ "$2" = "" ]; then
  if [ "$2" = "sleep" ]; then
    ollama stop $model
  else
    ollama run $model "$@" --hidethinking
  fi
else
  ollama run $model --hidethinking
fi
