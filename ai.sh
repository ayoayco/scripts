#! /bin/bash

# Load config
. ${HOME}/ayo.conf

host=$ollama_remote_host

model=$helper
modelfile=$helper_modelfile

# Initialize variables
other_args=${@:2}
typora_flag=false

# parse string args (when used as a function and passed "$@")
POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
  case $1 in
    -t)
      typora_flag=true
      shift # past argument
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

if ! [ "$other_args" = "" ]; then
  if [ "$other_args" = "open-webui" ]; then
      . $HOME/open-webui/.venv/bin/activate
      open-webui serve
      python --version
      deactivate
  elif [ "$other_args" = "remote" ]; then
      export OLLAMA_HOST=192.168.0.6
  elif [ "$other_args" = "list" ]; then
    OLLAMA_HOST=$host ollama list
  elif [ "$other_args" = "ps" ]; then
    OLLAMA_HOST=$host ollama ps
  elif [ "$other_args" = "rm" ]; then
    OLLAMA_HOST=$host ollama rm "$3"
  elif [ "$other_args" = "init" ]; then
    OLLAMA_HOST=$host ollama create $model -f $modelfile
  elif [ "$other_args" = "wake" ]; then
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
  elif [ "$other_args" = "update" ]; then
    curl -fsSL https://ollama.com/install.sh | sh
    echo "See instructions on how to expose ollama in the local network: https://git.ayo.run/ayo/scripts/src/branch/main/expose-ollama.md"
  elif [ "$other_args" = "sleep" ]; then
    OLLAMA_HOST=$host ollama stop $model
  else
    # If -t flag is set, use typora to display output
    if [ "$typora_flag" = true ]; then
      tempfile="$(mktemp)"
      OLLAMA_HOST=$host ollama run $model "$other_args" --hidethinking > $tempfile
      typora $tempfile > /dev/null 2>/dev/null &
    else
      # If no -t flag, just run the command normally
      OLLAMA_HOST=$host ollama run $model "$other_args" --hidethinking
    fi
  fi

else
  OLLAMA_HOST=$host ollama run $model --hidethinking
fi

# release memory
OLLAMA_HOST=$host ollama stop $model
