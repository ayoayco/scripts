#! /usr/bin/bash

# laptop display management

# Load config & functions
#. ${HOME}/ayo.conf
#. ${scripts_dir}/functions.sh

#command=$1

if [ "$1" = "1920" ] || [ "$1" = "1200" ]; then
  xrandr --output eDP-1 --mode 1920x1200
elif [ "$1" = "1280" ] || [ "$1" = "800" ]; then
  xrandr --output eDP-1 --mode 1280x800
else
  xrandr --output eDP-1 --mode 1680x1050
fi
