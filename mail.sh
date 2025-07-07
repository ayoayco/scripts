#! /usr/bin/bash

## mail automation / management

# Load config
. ${HOME}/ayo.conf
. ${scripts_dir}/functions.sh

# TODO: write log for echoes with >>>

command=$1

if [ "$1" = "task" ] || [ "$1" = "t" ]; then
  read -p "Task:" task
  mutt -s "$task" things
else
  mutt $1 $2 $3 $4 $5
fi
