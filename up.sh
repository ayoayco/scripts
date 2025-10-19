#! /usr/bin/bash

# Load config file
. ${HOME}/ayo.conf

sudo apt update && sudo apt upgrade -y

# if $skip_flatpak is set in config file
if ! [ $skip_flatpak ]; then
  flatpak update -y
fi
