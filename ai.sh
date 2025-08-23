# Load config
. ${HOME}/ayo.conf

if ! [ "$2" = "" ]; then
  if [ "$2" = "wake" ]; then
    . $HOME/llm_env/bin/activate
    . $HOME/llama-cpp/env.conf
    . $HOME/intel/oneapi/setvars.sh
    $HOME/llama-cpp/ollama serve
  else
    ollama run deepseek-r1:8b "$sys_prompt...<br /><hr />beginning prompt...<br /></hr /> $@" --hidethinking
  fi
else
  ollama run deepseek-r1:8b --hidethinking
fi
