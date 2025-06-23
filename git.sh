#! /usr/bin/bash

# git tools

# Load config
. ${HOME}/ayo.conf

command=$1
journal_dir="${notes_dir}/Journal"
month_dir=$(date +"%m %b")

getopts "t" typora; #check if -t flag is given

if [ "$1" = "stat" ]; then
  {
    git add .
    git status
  } || {
    # Report; TODO: write log
    echo ">>> Stat failed"
  }
elif [ "$1" = "commit" ]; then
  {
    git commit -m "$2"
  } || {
    # Report; TODO: write log
    echo ">>> Stat failed"
  }
else
  echo "git tools"
fi
