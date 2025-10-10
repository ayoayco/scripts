#! /bin/bash

# Load config
. ${HOME}/ayo.conf

host=$ollama_remote_host
model=$coder
modelfile=$coder_modelfile

# Initialize variables
typora_flag=false
other_args=${@:2}

# TODO: extract typora flag

if ! [ "$other_args" = "" ]; then
  if [ "$2" = "init" ]; then
    OLLAMA_HOST=$host ollama create $model -f $modelfile
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

OLLAMA_HOST=$host ollama stop $model
