# Load config
. ${HOME}/ayo.conf

model=$helper

if ! [ "$2" = "" ]; then
  if [ "$2" = "open-webui" ]; then
      . $HOME/open-webui/.venv/bin/activate
      open-webui serve
      python --version
      deactivate
  elif [ "$2" = "wake" ]; then
    . $HOME/llm_env/bin/activate

    export OLLAMA_NUM_GPU=999
    export no_proxy=localhost,127.0.0.1
    export ZES_ENABLE_SYSMAN=1
    source $HOME/intel/oneapi/setvars.sh
    export SYCL_CACHE_PERSISTENT=1

    $HOME/llama-cpp/ollama serve
    python --version
    deactivate

    echo $ZES_ENABLE_SYSMAN
    echo $SYCL_CACHE_PERSISTENT
  elif [ "$2" = "sleep" ]; then
    ollama stop $model
  else
    start_time=$(date +%s%N)
    ollama run $model "$@" --hidethinking
    end_time=$(date +%s%N)
    duration=$((end_time - start_time))
    duration_ms=$(echo "scale=3; $duration / 1000000" | bc)
    duration_s=$(echo "scale=3; $duration_ms / 1000" | bc)
    echo "Model $model took $duration_s s"
  fi
else
  ollama run $model --hidethinking
fi
