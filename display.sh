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
      xrandr --output "$internal" --mode 1920x1200
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
      xrandr \
        --output "$main" --primary --auto --left-of "$secondary" \
        --output "$secondary" --auto \
        --output "$internal" --off
      ;;
    "left")
      echo "Setting dual display left"
      xrandr \
        --output "$main" --primary --auto --right-of "$secondary" \
        --output "$internal" --off
      ;;
    "center"|"middle")
      echo "Setting dual display center"
      xrandr \
        --output "$internal" --auto \
        --output "$secondary" --auto --above "$internal" \
        --output "$main" --primary --auto --left-of "$secondary" \
        --output "$internal" --primary \
      ;;

    "full")
      echo "Enabling all monitors"
      xrandr \
        --output "$internal" --auto --mode 1680x1050 \
        --output "$secondary" --auto --left-of "$internal" \
        --output "$main" --primary --auto --left-of "$secondary" \
      ;;

    "main")
      echo "Setting single display mode (main)"
      xrandr \
        --output "$main" --primary --mode 1920x1080 --rate 119.99 \
        --output "$secondary" --off \
        --output "$internal" --off
      ;;
    "duplicate")
      echo "Setting single display mode (main)"
      xrandr \
        --output "$main" --mode 1280x720 --primary \
        --output "$secondary" --mode 1280x720 --same-as "$main" \
        --output "$internal" --off
      ;;

    "no-main")
      echo "Setting display mode no main"
      xrandr \
        --output "$main" --off \
        --output "$secondary" --auto --left-of "$internal" \
        --output "$internal" --auto --mode 1680x1050 \
      ;;

    "secondary")
      echo "Setting single display mode (secondary only)"
      xrandr --output "$main" --off \
        --output "$secondary" --auto \
        --output "$internal" --off
      ;;
    "internal")
      echo "Setting single display mode (secondary only)"
      xrandr --output "$main" --off \
        --output "$secondary" --off \
        --output "$internal" --auto
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
