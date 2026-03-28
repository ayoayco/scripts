#!/usr/bin/bash

# laptop display management

# Load config & functions
. ${HOME}/ayo.conf
. ${scripts_dir}/functions.sh

command=$2

function main() {
  case $command in
    "edit")
      echo "Editing config file"
      vim "$HOME/ayo.conf"
      ;;
  esac
}

mstart_time=$(date +%s%N)
main $@
end_time=$(date +%s%N)
duration=$((end_time - start_time))
duration_ms=$(echo "scale=3; $duration / 1000000" | bc)
duration_s=$(echo "scale=3; $duration_ms / 1000" | bc)
echo "Took $duration_s s"ain
