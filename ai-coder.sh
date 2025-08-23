if ! [ "$2" = "" ]; then
  ollama run qwen3-coder:30b "$@"
else
  ollama run qwen3-coder:30b
fi
