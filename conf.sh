#!/usr/bin/bash

# configuration management

. $HOME/ayo.conf

command=$2

function main() {
  case $command in
    "edit") # edit the script
      echo "Editing config script"
      vim "$scripts_dir/conf.sh"
      ;;
    "init") #TODO: a command that initializes the configuration
      echo "Initializing config file..."
      # check if there is an existing config file
        # if yes, ask if user is sure?
          # if yes, back up with datetime
      # copy example config file to $HOME/ayo.conf
      ;;
    *) # edit the configuration
      echo "Editing config file..."
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
