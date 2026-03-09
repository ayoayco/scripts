#!/usr/bin/bash

# laptop display management

# Load config & functions
. ${HOME}/ayo.conf
. ${scripts_dir}/functions.sh

command=$2

function main() {
  case $command in
    "edit")
      vim "${scripts_dir}/display.sh"
      ;;
    "hybrid")
      sudo system76-power graphics hybrid
      sudo reboot
      ;;
    "nvidia")
      sudo system76-power graphics nvidia
      sudo reboot
      ;;
    "big")
      echo "Setting display to big mode (1920x1200)"
      xrandr --output "$secondary" --mode 1920x1200
      ;;
    "small")
      echo "Setting display to small mode (1280x800)"
      xrandr --output "$secondary" --mode 1280x800
      ;;
    "list")
      echo "Listing all monitors"
      xrandr --listmonitors
      ;;
    "dual"|"right")
      echo "Setting dual display right"
      xrandr --output "$main" --primary --auto --left-of "$secondary" --output "$secondary"
      ;;
    "left")
      echo "Setting dual display left"
      xrandr --output "$main" --primary --auto --right-of "$secondary" --output "$secondary"
      ;;
    "center"|"middle")
      echo "Setting dual display center"
      xrandr \
        --output "$main" --auto --above "$secondary" \
        --output "$secondary" --primary
      ;;
    "ultra")
      echo "Setting single display mode (ultrawide)"
      xrandr --output "$secondary" --off \
        --output "$main" --auto
        --mode 3840x2160
      ;;
    "solo")
      echo "Setting single display mode (secondaryal only)"
      xrandr --output "$main" --off \
        --output "$secondary" --auto
      ;;
    *)
      echo "Setting display to preferred size (1680x1050)"
      xrandr --output "$secondary" --output "$secondary"
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
