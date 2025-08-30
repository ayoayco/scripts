#! /usr/bin/env bash

# Load config
. ${HOME}/ayo.conf
. ${scripts_dir}/functions.sh

{
case $1 in
  ## SHORTCUTS

  ja) # journal append
    . ${scripts_dir}/journal.sh append "$@"
    ;;
  jt) # journal using typora
    . ${scripts_dir}/journal.sh -t "$@"
    ;;

  tl) # Tasks list
  . ${scripts_dir}/tasks.sh list "$@"
  ;;
  to) # Tasks open
  . ${scripts_dir}/tasks.sh open "$@"
  ;;
  tr) # Tasks remove
  . ${scripts_dir}/tasks.sh remove "$@"
  ;;
  td) # Tasks mark as done
  . ${scripts_dir}/tasks.sh done "$@"
  ;;

  nd) # Notes diff
    . ${scripts_dir}/notes.sh diff
    ;;
  ns) # Notes sync
    . ${scripts_dir}/notes.sh sync
    ;;
  nl) # Notes list
    . ${scripts_dir}/notes.sh list "$@"
    ;;
  no) # Notes open
    . ${scripts_dir}/notes.sh open "$@"
    ;;
  nr) # Notes remove
    . ${scripts_dir}/notes.sh remove "$@"
    ;;
  na) # Notes archive
    . ${scripts_dir}/notes.sh archive "$@"
    ;;
  nc) # Notes copy
    . ${scripts_dir}/notes.sh copy "$@"
    ;;
  nt) # Notes using typora
    . ${scripts_dir}/notes.sh -t "$@"
    ;;

  gd) # git diff
    . ${scripts_dir}/git.sh diff "$@"
    ;;
  gs) # git status
    . ${scripts_dir}/git.sh stat "$@"
    ;;
  gp) # git push
    . ${scripts_dir}/git.sh push "$@"
    ;;

  mt) # mail task
    . ${scripts_dir}/mail.sh task
    ;;

  ## SCRIPTS

  cozy)
    . ${scripts_dir}/cozy.sh "$@"
    ;;
  ai-coder)
    . ${scripts_dir}/ai-coder.sh "$@"
    ;;
  ai-brainstorm)
    . ${scripts_dir}/ai-brainstorm.sh "$@"
    ;;
  ai-helper)
    . ${scripts_dir}/ai.sh "$@"
    ;;
  ai)
    . ${scripts_dir}/ai.sh "$@"
    ;;
  m | mail)
    . ${scripts_dir}/mail.sh "$@"
    ;;
  d | display)
    . ${scripts_dir}/display.sh "$@"
    ;;
  u | up)
    . ${scripts_dir}/up.sh "$@"
    ;;
  g | git)
    . ${scripts_dir}/git.sh "$@"
    ;;
  n | notes)
    . ${scripts_dir}/notes.sh "$@"
    ;;
  t | tasks)
    . ${scripts_dir}/tasks.sh "$@"
    ;;
  j | journal)
    . ${scripts_dir}/journal.sh "$@"
    ;;
  c | config)
    echo 'Config script in-progress'
    ;;
  vm | mac)
    quickemu --vm ${HOME}/macos-monterey.conf --width 1920 --height 1080
    ;;
  ms)
    quickemu --vm ${HOME}/macos-monterey.conf --kill
    ;;
esac
}
