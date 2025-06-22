#! /usr/bin/bash

case $1 in
  ## SHORTCUTS

  js) # js - journal sync
    . ${HOME}/Projects/scripts/journal.sh sync
    ;;
  jn) # js - journal note
    . ${HOME}/Projects/scripts/journal.sh note
    ;;

  ## SCRIPTS

  m | mac)
    quickemu --vm macos-monterey.conf
    ;;
  j | journal)
    . ${HOME}/Projects/scripts/journal.sh $2 $3 $4 $5
    ;;
  c | config)
    echo 'Config script in-progress'
    ;;
esac
