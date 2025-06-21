#! /usr/bin/bash

journal_dir="/home/ayo/notes/Journal"

date_today=$(date +'%m-%d-%Y')
date_today_file_name=$(date +'%m.%d.%Y')
month_dir=$(date +"%m %b")
file_name="${date_today_file_name}.md"
full_path="${journal_dir}/${month_dir}/${file_name}"

# IF Not Exists: create file & echo date
if ! test -f "$full_path"; then
  install -Dv /dev/null $full_path
  echo $date_today > "$full_path"
fi

# Open entry in editor
vim "$full_path"

# Report, TODO: write log
echo ">>> " $month_dir / $file_name
