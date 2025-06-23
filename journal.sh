#! /usr/bin/bash

# Load config
. ${HOME}/ayo.conf

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
elif [ "$1" = "note" ]; then
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
    vim "$full_path"

  } || {
    echo ">>> New note failed"
  }
else
  {
    file_name=$(date +'%m.%d.%Y').md
    full_path="${journal_dir}/${month_dir}/${file_name}"

    # IF Not Exists: create file & echo date
    if ! test -f "$full_path"; then
      install -Dv /dev/null "$full_path"
      # TODO: update to correct heading from old entries
      date_heading=$(date +'%b %d, %Y, %a %r')
      echo $date_heading > "$full_path"
    fi

    # Open in editor
    vim "$full_path"
  } || {
    # Report; TODO: write log
    echo ">>> " $full_path
  }
fi
