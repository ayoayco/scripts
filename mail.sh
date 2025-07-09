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
  echo "Use ${bold}mail task${dlob} or ${bold}mt${dlob} to send a task to Things. Otherwise, use ${bold}mutt${dlob} for mail"
fi
