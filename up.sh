#! /usr/bin/bash

# Update commands

# Load config & functions
#. ${HOME}/ayo.conf
#. ${scripts_dir}/functions.sh

#command=$1

sudo apt update && sudo apt upgrade -y
