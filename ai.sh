# Load config
. ${HOME}/ayo.conf

model=$helper
modelfile=$helper_modelfile

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

  if [ "$other_args" = "open-webui" ]; then
      . $HOME/open-webui/.venv/bin/activate
      open-webui serve
      python --version
      deactivate
  elif [ "$other_args" = "init" ]; then
    ollama create $model -f $modelfile
  elif [ "$other_args" = "wake" ]; then
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
  elif [ "$other_args" = "sleep" ]; then
    ollama stop $model
  else
    # If -t flag is set, use typora to display output
    if [ "$typora_flag" = true ]; then
      tempfile="$(mktemp)"
      ollama run $model "$other_args" > $tempfile
      typora $tempfile
    else
      # If no -t flag, just run the command normally
      ollama run $model "$other_args"
    fi
  fi

else
  ollama run $model
fi
