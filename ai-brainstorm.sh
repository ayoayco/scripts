# Load config
. ${HOME}/ayo.conf

model=$brainstorm
modelfile=$brainstorm_modelfile

if ! [ "$2" = "" ]; then
  if [ "$2" = "sleep" ]; then
    ollama stop $model
  elif [ "$2" = "init" ]; then
    ollama create $model -f "$modelfile"
  else
    start_time=$(date +%s%N)
    ollama run $model "$@"
    end_time=$(date +%s%N)
    duration=$((end_time - start_time))
    duration_ms=$(echo "scale=3; $duration / 1000000" | bc)
    duration_s=$(echo "scale=3; $duration_ms / 1000" | bc)
    echo "Model $model took $duration_s s"
  fi
else
  ollama run $model
fi
