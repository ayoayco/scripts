#! /usr/bin/bash

# Load config
. ${HOME}/.ayo.config

command=$1
journal_dir="${notes_dir}/Journal"
month_dir=$(date +"%m %b")


if [ "$1" = "sync" ]; then
  {
    path="${notes_dir}/"
    cd "$path"
    git pull
    git add .
    git commit -m "[script] update/add entrie/s"
    git push
  } || {
    # Report; TODO: write log
    echo ">>> Sync failed"
  }
else
  file_name=$(date +'%m.%d.%Y').md
  full_path="${journal_dir}/${month_dir}/${file_name}"

  # IF Not Exists: create file & echo date
  if ! test -f "$full_path"; then
    install -Dv /dev/null "$full_path"
    # TODO: update to correct heading from old entries
    # Jun 17, 2025, Tue 10:24 PM
    heading=$(date +'%b %d, %Y, %a %r')
    echo $heading > "$full_path"
  fi

  # Open in editor
  typora "$full_path"

  # Report; TODO: write log
  echo ">>> " $full_path
fi
