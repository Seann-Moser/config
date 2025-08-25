#!/bin/bash

# Check if Cider is running using the simpler 'Cider' process name
if pgrep -f "Cider" > /dev/null; then
    # If Cider is running, try to play/pause it
    playerctl play-pause --player=cider
else
    # If Cider is not running, launch it
    flatpak run sh.cider.genten & # Use & to run in the background and not block Waybar
fi