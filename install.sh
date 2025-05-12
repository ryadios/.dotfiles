#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$HOME/.dotfiles"
CONFIG_DIR="$HOME/.config"

log_info()    { printf "\033[1;32m[INFO]\033[0m %s\n" "$1"; }
log_warn()    { printf "\033[1;33m[WARN]\033[0m %s\n" "$1"; }
log_error()   { printf "\033[1;31m[ERROR]\033[0m %s\n" "$1"; }
log_action()  { printf "\033[1;34m[ACTION]\033[0m %s\n" "$1"; }

mkdir -p "$CONFIG_DIR"

log_info "Linking top-level dotfiles from $DOTFILES"

for file in "$DOTFILES"/.*; do
    filename="$(basename "$file")"

    # Skip dotfiles you don't want to link
    [[ "$filename" == "." || "$filename" == ".." || "$filename" == ".config" || "$filename" == ".git" ]] && continue

    target="$HOME/$filename"

    if [ -L "$target" ]; then
        if [ ! -e "$target" ]; then
            log_warn "Broken symlink found: $target"
            log_action "Fixing symlink: $target -> $file"
            ln -sf "$file" "$target"
        else
            log_info "Valid symlink exists: $target"
        fi
    elif [ -e "$target" ]; then
        log_warn "File exists and is not a symlink, skipping: $target"
    else
        log_action "Linking $target -> $file"
        ln -s "$file" "$target"
    fi
done

log_info "Linking config files and directories from $DOTFILES/.config"

for item in "$DOTFILES/.config"/*; do
    name="$(basename "$item")"
    target="$CONFIG_DIR/$name"

    if [ -L "$target" ]; then
        if [ ! -e "$target" ]; then
            log_warn "Broken symlink found: $target"
            log_action "Fixing symlink: $target -> $item"
            ln -sf "$item" "$target"
        else
            log_info "Valid symlink exists: $target"
        fi
    elif [ -e "$target" ]; then
        log_warn "File/dir exists and is not a symlink, skipping: $target"
    else
        log_action "Linking $target -> $item"
        ln -s "$item" "$target"
    fi
done

log_info "All done!"
