#! /usr/bin/bash

journal_dir="${HOME}/notes/Journal"
month_dir=$(date +"%m %b")
file_name=$(date +'%m.%d.%Y').md
full_path="${journal_dir}/${month_dir}/${file_name}"

# IF Not Exists: create file & echo date
if ! test -f "$full_path"; then
  install -Dv /dev/null $full_path
  # TODO: update to correct heading from old entries
  heading=$(date +'%m-%d-%Y')
  echo $heading > "$full_path"
fi

# Open in editor
vim "$full_path"

# Report; TODO: write log
echo ">>> " $full_path
