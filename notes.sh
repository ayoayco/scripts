#! /usr/bin/bash

## notes management

# Load config
. ${HOME}/ayo.conf
. ${scripts_dir}/functions.sh

# TODO: write log for echoes with >>>

command=$1

getopts "t" typora; #check if -t flag is given

function editFile() {
  notesSync

  # Open in editor
  if [ "$typora" = "t" ]; then
    typora "$1"
  else
    vim "$1"
  fi

  notesSync
}

function createNote() {
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

    editFile "$full_path"

  } || {
    echo ">>> New note failed"
  }
}

if [ "$1" = "list" ] || [ "$1" = "l" ]; then
  files=( $notes_dir/*.md )
  index=0
  for file in "${files[@]##*/}"; do
    ((index++))
    echo "$index) $file"
  done
elif [ "$1" = "open" ] || [ "$1" = "o" ]; then
  files=( $notes_dir/*.md )
  PS3="Open file #: "
  echo "Please select a file."
  COLUMNS=0; select file in "${files[@]##*/}"; do
      {
        echo "Opening $file"
        editFile "$file"
        break
      } ||
      {
        echo "bad choice"
        break
      }
    done
elif [ "$1" = "remove" ] || [ "$1" = "rm" ]; then
  files=( $notes_dir/*.md )
  PS3="Remove file #: "
  echo "Please select a file."
  COLUMNS=0; select file in "${files[@]##*/}"; do
      {
        echo  "Removing $file"
        rm "${notes_dir}/${file}"
        notesSync
        break
      } ||
      {
        echo "bad choice"
        break
      }
    done
else
  createNote
fi
