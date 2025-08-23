# Load config
. ${HOME}/ayo.conf

# model=deepseek-r1:8b
model=qwen3-coder:30b

if ! [ "$2" = "" ]; then
  if [ "$2" = "wake" ]; then
    . $HOME/llm_env/bin/activate
    . $HOME/llama-cpp/env.conf
    . $HOME/intel/oneapi/setvars.sh
    $HOME/llama-cpp/ollama serve
  else
    ollama run $model "$chat_prompt...<br /><hr />beginning prompt...<br /></hr /> $@" --hidethinking
  fi
else
  ollama run $model --hidethinking
fi
