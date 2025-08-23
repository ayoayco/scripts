#! /usr/bin/bash

# laptop display management

# Load config & functions
#. ${HOME}/ayo.conf
#. ${scripts_dir}/functions.sh

intern=eDP-1
extern=DP-1

command=$2

if [ $command = "big" ] || [ "$command" = "1920" ] || [ "$command" = "1200" ]; then
  xrandr --output "$intern" --mode 1920x1200
elif [ $command = "small" ] || [ "$command" = "1280" ] || [ "$command" = "800" ]; then
  xrandr --output "$intern" --mode 1280x800
elif [ $command = "solo" ]; then
  xrandr --output "$extern" --off --output "$intern" --auto
elif [ $command = "dual" ]; then
  xrandr --output "$extern" --mode 1680x1050 --right-of "$intern"
else
  xrandr --output "$intern" --mode 1680x1050
fi
