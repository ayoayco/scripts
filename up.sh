#! /usr/bin/bash

# Update commands

# Load config & functions
#. ${HOME}/ayo.conf
#. ${scripts_dir}/functions.sh

#command=$1

set_display_resolution() {
  if [ "$1" = "1920" ] || [ "$1" = "1200" ]; then
    xrandr --output eDP-1 --mode 1920x1200
  else
    xrandr --output eDP-1 --mode 1680x1050
  fi
}

if [ $1 = "display" ] || [ $1 = "d" ]; then
  set_display_resolution $2
else
  sudo apt update && sudo apt upgrade -y
  flatpak update -y
fi
