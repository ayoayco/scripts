#! /usr/bin/bash

case $1 in
  ## SHORTCUTS

  ja) # journal append
    . ${HOME}/Projects/scripts/journal.sh append $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  jt) # journal using typora
    . ${HOME}/Projects/scripts/journal.sh -t $2 $3 $4 $5 $6 $7 $8 $9
    ;;

  nl) # Notes list
    . ${HOME}/Projects/scripts/notes.sh list $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  no) # Notes open
    . ${HOME}/Projects/scripts/notes.sh open $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  nr) # Notes remove
    . ${HOME}/Projects/scripts/notes.sh remove $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  nt) # Notes using typora
    . ${HOME}/Projects/scripts/notes.sh -t $2 $3 $4 $5 $6 $7 $8 $9
    ;;

  gs) # git status
    . ${HOME}/Projects/scripts/git.sh stat $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  gp) # git push
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
