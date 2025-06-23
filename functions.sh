# NOTE: config should be loaded by the script using this shared functions.sh

# Sync notes via git
notesSync() {
  {
    path="${notes_dir}/"
    cd "$path"
    git pull --quiet
    git add .
    git commit -m "[script] update/add entrie/s" --quiet
    git push --quiet
  } || {
    # Report; TODO: write log
    echo ">>> Sync failed"
  }
}
