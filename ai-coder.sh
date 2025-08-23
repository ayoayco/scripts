# Load config
. ${HOME}/ayo.conf

if ! [ "$2" = "" ]; then
  ollama run qwen3-coder:30b "$sys_prompt...<br /><hr />beginning prompt...<br /></hr /> $@"
else
  ollama run qwen3-coder:30b
fi
