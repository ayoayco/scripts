#!/usr/bin/bash

# laptop display management

# Load config & functions
#. ${HOME}/ayo.conf
#. ${scripts_dir}/functions.sh

intern=eDP-1
extern=DP-1

command=$2

function main() {
  case $command in
    "big")
      echo "Setting display to big mode (1920x1200)"
      xrandr --output "$intern" --mode 1920x1200
      ;;
    "small")
      echo "Setting display to small mode (1280x800)"
      xrandr --output "$intern" --mode 1280x800
      ;;
    "list")
      echo "Listing all monitors"
      xrandr --listmonitors
      ;;
    "dual"|"right")
      echo "Setting dual display right"
      xrandr --output "$extern" --primary --auto --left-of "$intern" --output "$intern" --mode 1680x1050
      ;;
    "left")
      echo "Setting dual display left"
      xrandr --output "$extern" --primary --auto --right-of "$intern" --output "$intern" --mode 1680x1050
      ;;
    "center")
      echo "Setting dual display center"
      xrandr \
        --output "$extern" --auto --above "$intern" \
        --output "$intern" --primary --auto
      ;;
    "ultra")
      echo "Setting single display mode (ultrawide)"
      xrandr --output "$intern" --off \
        --output "$extern" --auto
      ;;
    "solo")
      echo "Setting single display mode (internal only)"
      xrandr --output "$extern" --off \
        --output "$intern" --auto
      ;;
    *)
      echo "Setting display to preferred size (1680x1050)"
      xrandr --output "$intern" --output "$intern" --mode 1680x1050
      ;;
  esac
  return 0
}

start_time=$(date +%s%N)
main $@
end_time=$(date +%s%N)
duration=$((end_time - start_time))
duration_ms=$(echo "scale=3; $duration / 1000000" | bc)
duration_s=$(echo "scale=3; $duration_ms / 1000" | bc)
echo "Took $duration_s s"
