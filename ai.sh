#! /bin/bash

# Load config
. ${HOME}/ayo.conf

host=$ollama_remote_host

model=$helper
modelfile=$helper_modelfile

# Initialize variables
command=${@:2}
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

function main() {
  case $command in
    "edit")
      vim "${scripts_dir}/ai.sh"
      ;;
    "open-webui")
      . $HOME/open-webui/.venv/bin/activate
      open-webui serve
      python --version
      deactivate
      ;;
    "remote")
      export OLLAMA_HOST=192.168.0.6
      ;;
    "list")
      OLLAMA_HOST=$host ollama list
      ;;
    "ps")
      OLLAMA_HOST=$host ollama ps
      ;;
    "rm")
      OLLAMA_HOST=$host ollama rm "$3"
      ;;
    "init")
      OLLAMA_HOST=$host ollama create $model -f $modelfile
      ;;
    "wake")
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
      ;;
    "update")
      curl -fsSL https://ollama.com/install.sh | sh
      echo "See instructions on how to expose ollama in the local network: https://git.ayo.run/ayo/scripts/src/branch/main/expose-ollama.md"
      ;;
    "sleep")
      OLLAMA_HOST=$host ollama stop $model
      ;;
    "")
      OLLAMA_HOST=$host ollama run $model --hidethinking
      ;;
    *)
      # If -t flag is set, use typora to display output
      if [ "$typora_flag" = true ]; then
        tempfile="$(mktemp)"
        OLLAMA_HOST=$host ollama run $model "$command" --hidethinking > $tempfile
        typora $tempfile > /dev/null 2>/dev/null &
      else
        # If no -t flag, just run the command normally
        OLLAMA_HOST=$host ollama run $model "$command" --hidethinking
      fi
    ;;
  esac

  # release memory
  OLLAMA_HOST=$host ollama stop $model
}

start_time=$(date +%s%N)
main $@
end_time=$(date +%s%N)
duration=$((end_time - start_time))
duration_ms=$(echo "scale=3; $duration / 1000000" | bc)
duration_s=$(echo "scale=3; $duration_ms / 1000" | bc)
echo "Took $duration_s s"
