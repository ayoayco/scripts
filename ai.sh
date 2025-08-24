# Load config
. ${HOME}/ayo.conf

model=$helper
modelfile=$helper_modelfile

if ! [ "$2" = "" ]; then
  if [ "$2" = "open-webui" ]; then
      . $HOME/open-webui/.venv/bin/activate
      open-webui serve
      python --version
      deactivate
  elif [ "$2" = "init" ]; then
    ollama create $model -f $modelfile
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
    # tempfile="$(mktemp)"
    # ollama run $model "$@" --hidethinking > $tempfile
    # typora $tempfile
    ollama run $model "$@" --hidethinking
  fi
else
  ollama run $model --hidethinking
fi
