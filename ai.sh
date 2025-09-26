#! /bin/bash

# Load config
. ${HOME}/ayo.conf

host=$ollama_remote_host

model=$helper
modelfile=$helper_modelfile

# Initialize variables
typora_flag=false
other_args=${@:2}

# TODO: extract typora flag

if ! [ "$other_args" = "" ]; then
  if [ "$other_args" = "open-webui" ]; then
      . $HOME/open-webui/.venv/bin/activate
      open-webui serve
      python --version
      deactivate
  elif [ "$2" = "remote" ]; then
      export OLLAMA_HOST=192.168.0.6
  elif [ "$2" = "list" ]; then
    OLLAMA_HOST=$host ollama list
  elif [ "$2" = "ps" ]; then
    OLLAMA_HOST=$host ollama ps
  elif [ "$2" = "rm" ]; then
    OLLAMA_HOST=$host ollama rm "$3"
  elif [ "$2" = "init" ]; then
    OLLAMA_HOST=$host ollama create $model -f $modelfile
  elif [ "$2" = "wake" ]; then
    . $HOME/llm_env/bin/activate

    unset OCL_ICD_VENDORS
    export OLLAMA_NUM_GPU=999
    export no_proxy=localhost,127.0.0.1
    export ZES_ENABLE_SYSMAN=1
    source $HOME/intel/oneapi/setvars.sh
    export SYCL_CACHE_PERSISTENT=1
    export SYCL_PI_LEVEL_ZERO_USE_IMMEDIATE_COMMANDLISTS=0

    $HOME/llama-cpp/ollama serve
    python --version
    deactivate

    echo $ZES_ENABLE_SYSMAN
    echo $SYCL_CACHE_PERSISTENT
  elif [ "$2" = "sleep" ]; then
    OLLAMA_HOST=$host ollama stop $model
  else
    # If -t flag is set, use typora to display output
    if [ "$typora_flag" = true ]; then
      tempfile="$(mktemp)"
      OLLAMA_HOST=$host ollama run $model "$other_args" > $tempfile
      typora $tempfile > /dev/null 2>/dev/null &
    else
      # If no -t flag, just run the command normally
      OLLAMA_HOST=$host ollama run $model "$other_args"
    fi
  fi

else
  OLLAMA_HOST=$host ollama run $model --think=false
fi
