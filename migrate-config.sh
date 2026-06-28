#!/bin/bash
# migrate-dotfiles.sh
set -e

DOTFILES="$HOME/.dotfiles"
CONFIG="$HOME/.config"

mkdir -p "$DOTFILES"
cd "$DOTFILES"

for app in "$CONFIG"/*/; do
    name=$(basename "$app")
    
    echo "Migratingme..."
    mv "$app" "$DOTFILES/$name/.config/"
    
    cd "$DOTFILES"
    stow "$name"
done

echo "Done! All .config apps stowed."