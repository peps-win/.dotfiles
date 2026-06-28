#!/bin/bash
# migrate-dotfiles.sh
set -e

DOTFILES="$HOME/.dotfiles"
CONFIG="$HOME/.config"

mkdir -p "$DOTFILES"

for app in "$CONFIG"/*/; do
    name=$(basename "$app")
    
    echo "Migrating $name..."
    mkdir -p "$DOTFILES/$name/.config"
    mv "$app" "$DOTFILES/$name/.config/$name"
    
    cd "$DOTFILES"
    stow "$name"
done

echo "Done! All .config apps stowed."