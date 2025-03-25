#!/usr/bin/env bash
#
# reinstall_all_packages.sh
#
# Script to reinstall packages stored in:
#   - pkglist_official.txt (official repo)
#   - pkglist_aur.txt (AUR)

#!/bin/bash

TPM_DIR="$HOME/.tmux/plugins/tpm"

if [ ! -d "$TPM_DIR" ]; then
    echo "TPM not found. Installing..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    echo "TPM installed successfully."
else
    echo "TPM is already installed."
fi

~/.tmux/plugins/tpm/bin/install_plugins
~/.tmux/plugins/tpm/bin/update_plugins all

set -e

# 1. Install official repo packages
echo "Installing official repository packages..."
if [ -f pkglist_official.txt ]; then
  sudo pacman -S --needed --noconfirm - < pkglist_official.txt
else
  echo "pkglist_official.txt not found."
fi

# 2. Install AUR packages (change 'yay' to your AUR helper of choice)
echo "Installing AUR packages..."
if [ -f pkglist_aur.txt ]; then
  if command -v yay &> /dev/null; then
    yay -S --needed --noconfirm - < pkglist_aur.txt
  else
    echo "AUR helper (yay) not found. Install it or modify this script for another AUR helper."
  fi
else
  echo "pkglist_aur.txt not found."
fi


TARGET=""

for dir in */ ; do
    # Check if it's actually a directory
    if [[ -d "$dir" ]]; then
        # Remove trailing slash for clarity with Stow
        package_name="${dir%/}"

        echo "Stowing: $package_name"
        
        # If you want to target a specific directory (e.g., ~/),
        # uncomment and use: stow -t "$TARGET" "$package_name"
        if [[ -n "$TARGET" ]]; then
            stow -t "$TARGET" "$package_name"
        else
            stow "$package_name"
        fi
    fi
done

