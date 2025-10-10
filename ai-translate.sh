#! /bin/bash

# Load config
. ${HOME}/ayo.conf

host=$ollama_remote_host
model="helper:latest"

TEMP=$(mktemp)
vim $TEMP

PROMPT="Translate everything that follows into English. Only give me the translated text in English."

OUTPUT=$(mktemp)

OLLAMA_HOST=$host ollama run $model "$PROMPT -- " < $TEMP > $OUTPUT

typora $OUTPUT
