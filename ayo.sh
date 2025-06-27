#! /usr/bin/env bash

# Load config
. ${HOME}/ayo.conf
. ${scripts_dir}/functions.sh

{

case $1 in
  ## SHORTCUTS

  ja) # journal append
    . ${scripts_dir}/journal.sh append $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  jt) # journal using typora
    . ${scripts_dir}/journal.sh -t $2 $3 $4 $5 $6 $7 $8 $9
    ;;

  tl) # Tasks list
  . ${scripts_dir}/tasks.sh list $2 $3 $4 $5 $6 $7 $8 $9
  ;;
  to) # Tasks open
  . ${scripts_dir}/tasks.sh open $2 $3 $4 $5 $6 $7 $8 $9
  ;;
  tr) # Tasks remove
  . ${scripts_dir}/tasks.sh remove $2 $3 $4 $5 $6 $7 $8 $9
  ;;
  td) # Tasks mark as done
  . ${scripts_dir}/tasks.sh done $2 $3 $4 $5 $6 $7 $8 $9
  ;;

  nd) # Notes diff
    . ${scripts_dir}/notes.sh diff
    ;;
  ns) # Notes sync
    . ${scripts_dir}/notes.sh sync
    ;;
  nl) # Notes list
    . ${scripts_dir}/notes.sh list $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  no) # Notes open
    . ${scripts_dir}/notes.sh open $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  nr) # Notes remove
    . ${scripts_dir}/notes.sh remove $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  na) # Notes archive
    . ${scripts_dir}/notes.sh archive $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  nc) # Notes copy
    . ${scripts_dir}/notes.sh copy $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  nt) # Notes using typora
    . ${scripts_dir}/notes.sh -t $2 $3 $4 $5 $6 $7 $8 $9
    ;;

  gd) # git diff
    . ${scripts_dir}/git.sh diff $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  gs) # git status
    . ${scripts_dir}/git.sh stat $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  gp) # git push
    . ${scripts_dir}/git.sh push $2 $3 $4 $5 $6 $7 $8 $9
    ;;

  ## SCRIPTS

  u | up)
    . ${scripts_dir}/up.sh $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  g | git)
    . ${scripts_dir}/git.sh $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  n | notes)
    . ${scripts_dir}/notes.sh $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  t | tasks)
    . ${scripts_dir}/tasks.sh $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  j | journal)
    . ${scripts_dir}/journal.sh $2 $3 $4 $5 $6 $7 $8 $9
    ;;
  c | config)
    echo 'Config script in-progress'
    ;;
  m | mac)
    quickemu --vm ${HOME}/macos-monterey.conf --width 1920 --height 1080
    ;;
  ms)
    quickemu --vm ${HOME}/macos-monterey.conf --kill
    ;;
esac
}
