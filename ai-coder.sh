# Load config
. ${HOME}/ayo.conf

model=qwen3-coder:30b

if ! [ "$2" = "" ]; then
  ollama run $model "%coder_prompt...<br /><hr />beginning prompt...<br /></hr /> $@" --hidethinking
else
  ollama run $model --hidethinking
fi
