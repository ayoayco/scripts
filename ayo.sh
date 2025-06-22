#! /usr/bin/bash

case $1 in
  js)
    . ${HOME}/Projects/scripts/journal.sh sync
    ;;
  j | journal)
    . ${HOME}/Projects/scripts/journal.sh $2 $3 $4 $5
    ;;
  c | config)
    echo 'Config script in-progress'
    ;;
esac
