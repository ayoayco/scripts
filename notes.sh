#! /usr/bin/bash

# Load config
. ${HOME}/ayo.conf
. ${scripts_dir}/functions.sh

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

function main() {
  case "$1" in
    # DIFF: Show git diff of staged changes
    diff|d)
      cd "$notes_dir"
      git add .
      git diff --staged .
      ;;

    # SYNC: Sync notes directory with remote
    sync|s)
      notesSync
      ;;

    # LIST: List all notes in directory
    list|l)
      echo "ACTIVE NOTES: "
      notesSync
      if ! [ "$2" = "" ]; then
        files=( "$notes_dir/$2"/*.md )
      else
        files=( "$notes_dir"/*.md )
      fi
      index=0
      for file in "${files[@]##*/}"; do
        ((index++))
        echo "$index) $file"
      done
      ;;

    # OPEN: Open a note from list or by index
    open|o)
      notesSync
      files=( "$notes_dir"/*.md )

      if ! [ "$2" = "" ]; then
        index=$((2-1))
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
      ;;

    # REMOVE: Remove a note from list or by index
    remove|rm)
      notesSync
      files=( "$notes_dir"/*.md )

      if ! [ "$2" = "" ]; then
        index=$((2-1))
        remove_file=${files[$index]}
        echo "Removing $remove_file"
        rm "$remove_file"
        notesSync
      else
        PS3="Remove file #: "
        echo "Please select a file to REMOVE."
        select file in "${files[@]##*/}"; do
            {
              echo "Removing $file"
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
      ;;

    # ARCHIVE: Move a note to archive directory
    archive|a)
      ;;
    # DEFAULT: Default action - create new note
    *)
      createNote
      ;;
  esac
}

main "$@"
