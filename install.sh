#!/usr/bin/sh

DOTFILES="$HOME/.dotfiles"
CONFIG="$DOTFILES/.config"
TARGET="$HOME"
TARGET_CONFIG="$TARGET/.config"

IGNORE=("README.md" "LICENSE" ".git" ".gitignore")

for file in "$DOTFILES"/.[^.]*; do
    name=$(basename "$file")
    # Skips ignored files and folders
    if [[ " ${IGNORE[@]} " =~ " $name " ]] || [ -d "$file" ]; then
        continue
    fi

    ln -s "$file" "$TARGET/$name"
done

for file in "$CONFIG"/*; do
    dir=$(basename "$file")
    # Skips files
    if [ -f "$file" ]; then
        continue
    fi

    ln -s "$file" "$TARGET_CONFIG"
done
