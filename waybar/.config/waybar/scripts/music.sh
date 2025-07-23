#!/bin/bash

# Check if playerctl is installed
if ! command -v playerctl &> /dev/null; then
    echo "playerctl not found. Please install it."
    exit 1
fi

# Get metadata from playerctl
artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)
status=$(playerctl status 2>/dev/null)

# Format output based on status
if [[ "$status" == "Playing" ]]; then
    echo "$artist - $title 🎵"
elif [[ "$status" == "Paused" ]]; then
    echo "$artist - $title ⏸️"
else
    echo "No Music 🎶"
fi