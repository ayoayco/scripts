# Load config
. ${HOME}/ayo.conf

model=$coder
modelfile=$coder_modelfile

if ! [ "$2" = "" ]; then
  if [ "$2" = "sleep" ]; then
    ollama stop $model
  elif [ "$2" = "init" ]; then
    ollama create "$model" -f "$modelfile"
  else
    ollama run $model "$@" --hidethinking
  fi
else
  ollama run $model --hidethinking
fi
