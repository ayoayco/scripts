#! /usr/bin/bash

## notes management

# Load config
. ${HOME}/ayo.conf
. ${scripts_dir}/functions.sh

# TODO: write log for echoes with >>>

command=$1

getopts "t" typora; #check if -t flag is given

if [ "$1" = "sync" ]; then
  notesSync
else
  {
    read -p "Enter file name: " title
    file_name=$title.md
    full_path="${notes_dir}/${file_name}"

    # IF Not Exists: create file & echo date
    if ! test -f "$full_path"; then
      install -Dv /dev/null "$full_path"
      # TODO: update to correct heading from old entries
      heading="# $title"
      echo $heading > "$full_path"
      date_heading=$(date +'%b %d, %Y, %a %r')
      echo $date_heading >> "$full_path"
    fi

    # Open in editor
    if [ "$typora" = "t" ]; then
      typora "$full_path"
    else
      vim "$full_path"
    fi

    notesSync
  } || {
    echo ">>> New note failed"
  }
fi
