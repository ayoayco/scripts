# NOTE: config should be loaded by the script using this shared functions.sh

# Sync notes via git
notesSync() {
  # check if online
  test="git.sr.ht"
  if timeout 0.5 ping -q -c 1 -W 1 $test >/dev/null; then
    {
      path="${notes_dir}/"
      cd "$path"
      git pull --quiet
      git add .
      git commit -m "[bash script] update/add entries" >> /dev/null
      git push --quiet
    } || {
      # Report; TODO: write log
      echo ">>> Sync failed"
    }
  fi
}


yes_or_no() {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0 ;;
            [Nn]*) return 1 ;;
        esac
    done
}
