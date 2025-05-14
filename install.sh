#!/bin/bash

DOTFILES="$HOME/.dotfiles"
TARGET="$HOME"
CONFIG="$TARGET/.config"
LOCAL="$TARGET/.local"

IGNORE=("README.md" "LICENSE" ".git" ".gitignore")

for file in "$DOTFILES"/.[^.]*; do
    name=$(basename "$file")
    # Skips ignored files and folders
    if [[ " ${IGNORE[@]} " =~ " $name " ]] || [ -d "$file" ]; then
        continue
    fi

    ln -s "$file" "$TARGET/$name"
done

for file in "$DOTFILES/.config"/*; do
    dir=$(basename "$file")
    # Skips files
    if [ -f "$file" ]; then
        continue
    fi

    ln -s "$file" "$CONFIG"
done

for file in "$DOTFILES/bin"/*; do
    name=$(basename "$file")
    # Skips folder
    if [ -d "$file" ]; then
        continue
    fi

    ln -s "$file" "$LOCAL/bin/$name"
done
