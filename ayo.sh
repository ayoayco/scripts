#! /usr/bin/bash

case $1 in
  j | journal)
    . ${HOME}/Projects/scripts/journal.sh
    ;;
  c | config)
    echo 'Config script in-progress'
    ;;
esac
