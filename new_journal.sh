#! /usr/bin/bash

echo "NEW NOTE"

journal_dir="/home/ayo/notes/Journal"

file_name=$(date +'%m.%d.%Y').md
month_dir=$(date +"%m %b")
full_path="${journal_dir}/${month_dir}/${file_name}"

# IF Not Exists: create file & echo date
if ! test -f "$full_path"; then
  install -Dv /dev/null $full_path
  # TODO: update to correct heading from old entries
  heading=$(date +'%m-%d-%Y')
  echo writing $heading to "$full_path"
  echo $heading > "$full_path"
fi

# Open in editor
vim "$full_path"

# Report; TODO: write log
echo ">>> " $month_dir / $file_name
