#!/usr/bin/env bash
#
# reinstall_all_packages.sh
#
# Script to reinstall packages stored in:
#   - pkglist_official.txt (official repo)
#   - pkglist_aur.txt (AUR or equivalent)

set -e

# Detect package manager
detect_package_manager() {
    if command -v yay &> /dev/null; then
        echo "yay"
    elif command -v pacman &> /dev/null; then
        echo "pacman"
    elif command -v apt &> /dev/null; then
        echo "apt"
    else
        echo "unsupported"
    fi
}

PKG_MANAGER=$(detect_package_manager)

# TPM Installation
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

# Install official repo packages
echo "Installing official repository packages..."
if [ -f pkglist_official.txt ]; then
    case $PKG_MANAGER in
        yay|pacman)
            sudo pacman -S --needed --noconfirm - < pkglist_official.txt
            ;;
        apt)
            xargs -a pkglist_official.txt sudo apt install -y
            ;;
        *)
            echo "Unsupported package manager for official packages."
            ;;
    esac
else
    echo "pkglist_official.txt not found."
fi

# Install AUR packages or equivalent
echo "Installing AUR or custom packages..."
if [ -f pkglist_aur.txt ]; then
    case $PKG_MANAGER in
        yay)
            yay -S --needed --noconfirm - < pkglist_aur.txt
            ;;
        pacman)
            echo "pacman does not support AUR. Please install 'yay' or another AUR helper."
            ;;
        apt)
            echo "AUR packages not supported on apt. You may need to install manually or convert the list."
            ;;
        *)
            echo "Unsupported package manager for AUR packages."
            ;;
    esac
else
    echo "pkglist_aur.txt not found."
fi

# Stow dotfiles
TARGET=""
for dir in */ ; do
    if [[ -d "$dir" ]]; then
        package_name="${dir%/}"
        echo "Stowing: $package_name"
        if [[ -n "$TARGET" ]]; then
            stow -t "$TARGET" "$package_name"
        else
            stow "$package_name"
        fi
    fi
done
