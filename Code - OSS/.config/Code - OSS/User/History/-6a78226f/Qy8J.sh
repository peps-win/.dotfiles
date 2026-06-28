#!/bin/bash
set -e

DOTFILES="$HOME/dotfiles"
mkdir -p "$DOTFILES"

# ── .config apps ────────────────────────────────────────
mkdir -p "$DOTFILES/config-apps"
for app in "$HOME/.config"/*/; do
    name=$(basename "$app")
    echo "  .config/$name"
    mkdir -p "$DOTFILES/config-apps/.config"
    mv "$app" "$DOTFILES/config-apps/.config/$name"
done

# ── home dotfiles ────────────────────────────────────────
mkdir -p "$DOTFILES/home"
for f in "$HOME"/.[^.]*; do
    name=$(basename "$f")
    # skip .config itself and a few things you don't want to stow
    [[ "$name" == ".config" ]] && continue
    [[ "$name" == ".local" ]] && continue
    [[ "$name" == ".cache" ]] && continue
    [[ "$name" == ".git" ]] && continue
    echo "  ~/$name"
    mv "$f" "$DOTFILES/home/$name"
done

# ── stow everything ─────────────────────────────────────
cd "$DOTFILES"
stow config-apps
stow home

echo "Done!"