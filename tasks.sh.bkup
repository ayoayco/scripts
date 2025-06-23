#! /usr/bin/bash

## tasks management

# Load config
. ${HOME}/ayo.conf
. ${scripts_dir}/functions.sh

# TODO: write log for echoes with >>>

command=$1

getopts "t" typora; #check if -t flag is given

function editFile() {
  notesSync

  edit_file="${tasks_dir}/$1"
  # Open in editor
  if [ "$typora" = "t" ]; then
    typora "$edit_file"
  else
    vim "$edit_file"
  fi

  notesSync
}

function createTask() {
  {
    read -p "Create new task: " title

    if [ "$title" = "" ]; then
      echo "Title cannot be empty."
      exit;
    fi;

    file_name=$title.md
    full_path="${tasks_dir}/${file_name}"

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


## LIST tasks in directory
if [ "$1" = "list" ] || [ "$1" = "l" ]; then
  files=( $tasks_dir/*.md )
  index=0
  notesSync
  for file in "${files[@]##*/}"; do
    ((index++))
    echo "$index) $file"
  done

## OPEN a note from a list
elif [ "$1" = "open" ] || [ "$1" = "o" ]; then
  files=( $tasks_dir/*.md )
  PS3="Open file #: "
  echo "Please select a file to OPEN."
  notesSync
  select file in "${files[@]##*/}"; do
      {
        editFile "$file"
        break
      } ||
      {
        echo "bad choice"
        break
      }
    done

## MARK AS DONE a note from a list
elif [ "$1" = "done" ] || [ "$1" = "d" ]; then
  files=( $tasks_dir/*.md )
  PS3="Mark as Done, file #: "
  echo "Mark a task as DONE ($(ls ${notes_dir}/tasks/done | wc -l))."
  notesSync
  select file in "${files[@]##*/}"; do
      {
        mv "${tasks_dir}/${file}" "${tasks_dir}/done"
        notesSync
        break
      } ||
      {
        echo "bad choice"
        break
      }
    done


## REMOVE a note from a list
elif [ "$1" = "remove" ] || [ "$1" = "rm" ]; then
  files=( $tasks_dir/*.md )
  PS3="Remove file #: "
  echo "Please select a file to REMOVE."
  notesSync
  select file in "${files[@]##*/}"; do
      {
        echo  "Removing $file"
        rm "${tasks_dir}/${file}"
        notesSync
        break
      } ||
      {
        echo "bad choice"
        break
      }
    done

## CREATE a note (default)
else
  createTask
fi
