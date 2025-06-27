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

  clear
  notesSync
}

function createNote() {
  {
    read -p "Create new note: " title

    if [ "$title" = "" ]; then
      echo "Title cannot be empty."
      exit;
    fi;

    file_name=$title.md
    full_path="${notes_dir}/${file_name}"

    # IF Not Exists: create file & echo date
    if ! test -f "$full_path"; then
      install -Dv /dev/null "$full_path" >/dev/null
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


## DIFF
if [ "$1" = "diff" ] || [ "$1" = "d" ]; then
  cd $notes_dir
  git add .
  git diff --staged .
## SYNC notes in directory
elif [ "$1" = "sync" ] || [ "$1" = "s" ]; then
  notesSync

## LIST notes in directory
elif [ "$1" = "list" ] || [ "$1" = "l" ]; then
  echo "ACTIVE NOTES: "
  notesSync
  files=( $notes_dir/*.md )
  index=0
  for file in "${files[@]##*/}"; do
    ((index++))
    echo "$index) $file"
  done

## OPEN a note from a list
elif [ "$1" = "open" ] || [ "$1" = "o" ]; then
  notesSync
  files=( $notes_dir/*.md )

  if ! [ "$2" = "" ]; then
    index=($2-1)
    open_file=${files[$index]}
    editFile "$open_file"
  else
    PS3="Open file #: "
    echo "Please select a file to OPEN."
    select file in "${files[@]##*/}"; do
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
  fi

## REMOVE a note from a list
elif [ "$1" = "remove" ] || [ "$1" = "rm" ]; then
  notesSync
  files=( $notes_dir/*.md )

  if ! [ "$2" = "" ]; then
    index=($2-1)
    remove_file=${files[$index]}
    echo  "Removing $remove_file"
    rm "$remove_file"
    notesSync
  else
    PS3="Remove file #: "
    echo "Please select a file to REMOVE."
    select file in "${files[@]##*/}"; do
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
  fi

## ARCHIVE a note from a list
elif [ "$1" = "archive" ] || [ "$1" = "a" ]; then
  notesSync
  files=( $notes_dir/*.md )

  if ! [ "$2" = "" ]; then
    index=($2-1)
    archive_file=${files[$index]}
    echo  "Archiving $archive_file"
    mv "$archive_file" "${archive_dir}/"
    notesSync
  else
    PS3="Archive file #: "
    echo "Move a note to ARCHIVE ($(ls ${archive_dir} | wc -l))."
    select file in "${files[@]##*/}"; do
        {
          echo  "Archiving $file"
          mv "${notes_dir}/${file}" "${archive_dir}/"
          notesSync
          break
        } ||
        {
          echo "bad choice"
          break
        }
      done
  fi

## COPY content a note from a list
elif [ "$1" = "copy" ] || [ "$1" = "c" ]; then
  files=( $notes_dir/*.md )

  if ! [ "$2" = "" ]; then
    index=($2-1)
    copy_file=${files[$index]}
    echo  "Copied content of $copy_file"
    xclip -sel c < "$copy_file"
  else
    PS3="Copy file content #: "
    echo "Select a note to COPY Content."
    select file in "${files[@]##*/}"; do
        {
          echo  "Copied content of $file"
          xclip -sel c < "${notes_dir}/${file}"
          break
        } ||
        {
          echo "bad choice"
          break
        }
      done
  fi


## CREATE a note (default)
else
  createNote
fi
