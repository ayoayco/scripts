#! /usr/bin/bash

case $1 in
  ## SHORTCUTS

  js) # js - journal sync
    . ${HOME}/Projects/scripts/journal.sh sync $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  ns) # js - journal sync
    . ${HOME}/Projects/scripts/notes.sh sync $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  gs) # js - journal sync
    . ${HOME}/Projects/scripts/git.sh stat $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  gc) # js - journal sync
    . ${HOME}/Projects/scripts/git.sh commit $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  gp) # js - journal sync
    . ${HOME}/Projects/scripts/git.sh push $2 $3 $4 $5 $6 $7 $8 $9
    ;;

  ## SCRIPTS

  g | git)
    . ${HOME}/Projects/scripts/git.sh $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  n | notes)
    . ${HOME}/Projects/scripts/notes.sh $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  j | journal)
    . ${HOME}/Projects/scripts/journal.sh $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  c | config)
    echo 'Config script in-progress'
    ;;
  m | mac)
    quickemu --vm macos-monterey.conf --width 1920 --height 1080
    ;;
  ms)
    quickemu --vm macos-monterey.conf --kill
    ;;
esac
