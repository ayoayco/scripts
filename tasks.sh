#! /usr/bin/bash

## tasks management

# Load config
. ${HOME}/ayo.conf
. ${scripts_dir}/functions.sh

# TODO: write log for echoes with >>>

command=$1

getopts "t" typora; #check if -t flag is given

function listTasks() {
  files=( $tasks_dir/*.md )
  index=0
  echo "TASKS: "
  for file in "${files[@]##*/}"; do
    ((index++))
    echo "$index) $file"
  done
}

function listProjects() {
  cd "$tasks_dir"
  dirs=( */ )
  index=0
  echo "PROJECTS: "
  for dir in "${dirs[@]}"; do
    ((index++))
    echo "${index}) ${dir}"
  done
}

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

function createtask() {
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
      install -Dv /dev/null "$full_path" >/dev/null
      # TODO: update to correct heading from old entries
      heading="# $title"
      echo $heading > "$full_path"
      date_heading=$(date +'%b %d, %Y, %a %r')
      echo $date_heading >> "$full_path"
    else
      editFile "$full_path"
    fi


  } || {
    echo ">>> New task failed"
  }
}


## LIST tasks in directory
if [ "$1" = "list" ] || [ "$1" = "l" ]; then
  notesSync
  listProjects
  listTasks

## OPEN a task from a list
elif [ "$1" = "open" ] || [ "$1" = "o" ]; then
  notesSync
  files=( $tasks_dir/*.md )

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
          editFile "${tasks_dir}/$file"
          break
        } ||
        {
          echo "bad choice"
          break
        }
      done
  fi

## MARK AS DONE a task from a list
elif [ "$1" = "done" ] || [ "$1" = "d" ]; then
  notesSync
  files=( $tasks_dir/*.md )

  if ! [ "$2" = "" ]; then
    index=($2-1)
    done_file=${files[$index]}
    read -p "Resolution: " resolution
    echo $resolution >> "$done_file"
    mv "$done_file" "${tasks_dir}/.done/"
    notesSync
  else
    PS3="Mark as Done, file #: "
    echo "Mark a task as DONE ($(ls ${tasks_dir}/.done/ | wc -l))."
    select file in "${files[@]##*/}"; do
        {
          mv "${tasks_dir}/${file}" "${tasks_dir}/.done/"
          notesSync
          break
        } ||
        {
          echo "bad choice"
          break
        }
      done
  fi

## REMOVE a task from a list
elif [ "$1" = "remove" ] || [ "$1" = "rm" ]; then
  notesSync
  files=( $tasks_dir/*.md )

  if ! [ "$2" = "" ]; then
    index=($2-1)
    remove_file=${files[$index]}
    echo  "Removing $remove_file"
    rm "$remove_file"
    notesSync
  else
    PS3="Remove task #: "
    echo "Select a task to DELETE."
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
  fi

## COPY content a task from a list
elif [ "$1" = "copy" ] || [ "$1" = "c" ]; then
  files=( $tasks_dir/*.md )

  if ! [ "$2" = "" ]; then
    index=($2-1)
    copy_file=${files[$index]}
    echo  "Copied content of $copy_file"
    xclip -sel c < "$copy_file"
  else
    PS3="Copy file content #: "
    echo "Select a task to COPY Content."
    select file in "${files[@]##*/}"; do
        {
          echo  "Copied content of $file"
          xclip -sel c < "${tasks_dir}/${file}"
          break
        } ||
        {
          echo "bad choice"
          break
        }
      done
  fi

## Move a task to a project
elif [ "$1" = "move" ] || [ "$1" = "m" ]; then
  notesSync
  files=( $tasks_dir/*.md )
  if ! [ "$2" = "" ]; then
    index=($2-1)
    move_file=${files[$index]}
    editFile "$move_file"
  else
    PS3="Move file #: "
    echo "Please select a file to MOVE."
    select file in "${files[@]##*/}"; do
        {
          echo "Moving $file"
          PS3="Select Project: "
          echo "Select a project"
          cd $tasks_dir
          dirs=( */ )
          # Select a project to move the item to
          select directory in "${dirs[@]}"; do
            {
              mv "${tasks_dir}/${file}" "${tasks_dir}/${directory}"
              break
            } || {
              echo "bad choice"
              break
            }
          done

          break
        } ||
        {
          echo "bad choice"
          break
        }
      done
  fi

## CREATE a project
elif [ "$1" = "project" ] || [ "$1" = "p" ]; then
  read -p "Create new project: " project
  mkdir "$tasks_dir/$project"

## CREATE a task (default)
else

  createtask
fi
