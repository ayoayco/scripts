#! /usr/bin/bash

echo "NEW NOTE"

journal_dir="/home/ayo/notes/Journal"

date_today=$(date +'%m-%d-%Y')
file_name=$(date +'%m.%d.%Y').md
month_dir=$(date +"%m %b")
full_path="${journal_dir}/${month_dir}/${file_name}"

# IF Not Exists: create file & echo date
if ! test -f "$full_path"; then
  install -Dv /dev/null $full_path
  echo writing $date_today to "$full_path"
  echo $date_today > "$full_path"
fi

vim "$full_path"


# report, write log
echo ">>> " $month_dir / $file_name
