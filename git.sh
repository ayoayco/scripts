#! /usr/bin/bash

# git tools

# Load config
. ${HOME}/ayo.conf

command=$1
journal_dir="${notes_dir}/Journal"
month_dir=$(date +"%m %b")

git reset HEAD -- .
other_args="${@:2}"
echo $@
echo "args $other_args"

gitStatus() {
  {
    git add $other_args
    git status
  } || {
    # Report; TODO: write log
    echo ">>> Stat failed"
  }
}

gitCommit() {
  {
    git add $other_args
    read -p "Message: " message
    git commit -m "$message" $other_args
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

if [ "$1" = "diff" ] || [ "$1" = "d" ]; then
  git add $other_args
  git diff --staged
elif [ "$1" = "stat" ]; then
  gitStatus
elif [ "$1" = "push" ]; then
  gitPush
else
  git add $other_args
  git status
  gitCommit $other_args
  gitPush
fi
