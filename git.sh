#! /usr/bin/bash

# git tools

# Load config
. ${HOME}/ayo.conf

command=$1
journal_dir="${notes_dir}/Journal"
month_dir=$(date +"%m %b")

gitStatus() {
  {
    git add .
    git status
  } || {
    # Report; TODO: write log
    echo ">>> Stat failed"
  }
}

gitCommit() {
  {
    git add .
    read -p "Message: " message
    git commit -m "$message" $*
  }|| {
    # Report; TODO: write log
    echo ">>> Commit failed"
  }
}

gitPush() {
  {
    git push
  } || {
    # Report; TODO: write log
    echo ">>> Push failed"
  }
}

if [ "$1" = "stat" ]; then
  gitStatus
elif [ "$1" = "push" ]; then
  gitPush
else
  echo ">>> $1"
  if [ "$1" = "g" ] || [ "$1" = "git" ]; then
    git reset HEAD -- .
    git add .
    git status
    gitCommit
  else
    git reset HEAD -- .
    git add $*
    git status
    gitCommit $*
  fi
  gitPush
fi
