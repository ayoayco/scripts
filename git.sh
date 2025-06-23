#! /usr/bin/bash

# git tools

# Load config
. ${HOME}/ayo.conf

command=$1
journal_dir="${notes_dir}/Journal"
month_dir=$(date +"%m %b")

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
    git add .
    read -p "Message: " message
    git commit -m "$message" $2 $3 $4 $5 $6 $7 $8 $9
  }|| {
    # Report; TODO: write log
    echo ">>> Commit failed"
  }
elif [ "$1" = "push" ]; then
  {
    git push
  } || {
    # Report; TODO: write log
    echo ">>> Push failed"
  }
else
  echo "git tools"
fi
