#!/usr/bin/env bash

DOTFILES_DIR="$HOME/.dotfiles"
CONFIG_DIR="$DOTFILES_DIR/.config"
TARGET_HOME="$HOME"
TARGET_CONFIG="$HOME/.config"

BOLD="\033[1m"
UNDERLINE="\033[4m"
RESET="\033[0m"

PRIMARY="\033[38;5;111m"      # Light blue
SECONDARY="\033[38;5;150m"    # Light green
SUCCESS="\033[38;5;40m"       # Bright green
WARNING="\033[38;5;214m"      # Orange
ERROR="\033[38;5;196m"        # Bright red
INFO="\033[38;5;75m"          # Blue
MUTED="\033[38;5;245m"        # Gray

ICON_ERROR="✗"
ICON_INFO="ℹ"

IGNORE_FILES=("install.sh" "README.md" "LICENSE.md" ".git" ".gitignore")

print_section() {
    echo -e "${SECONDARY}${BOLD}$1${RESET}"
}

print_error() {
    echo -e "${ERROR}${ICON_ERROR} $1${RESET}"
}

print_info() {
    echo -e "${INFO}${ICON_INFO} $1${RESET}"
}

print_item() {
    echo -e "  ${MUTED}•${RESET} $1"
}

is_ignored() {
    local file="$1"
    for ignore in "${IGNORE_FILES[@]}"; do
        [[ "$file" == "$ignore" ]] && return 0
    done
    return 1
}

echo
print_info "Scanning for configuration files..."

CONFIG_NAMES=()
CONFIG_SOURCES=()
CONFIG_TARGETS=()

# Top-level dotfiles
for entry in "$DOTFILES_DIR"/.*; do
    name=$(basename "$entry")
    [[ "$name" == "." || "$name" == ".." || "$name" == ".config" ]] && continue
    is_ignored "$name" && continue

    CONFIG_NAMES+=("$name")
    CONFIG_SOURCES+=("$entry")
    CONFIG_TARGETS+=("$TARGET_HOME/$name")
done

# .config files and folders
if [ -d "$CONFIG_DIR" ]; then
    for entry in "$CONFIG_DIR"/*; do
        name=$(basename "$entry")
        if [ -d "$entry" ]; then
            CONFIG_NAMES+=("$name/")
            CONFIG_SOURCES+=("$entry")
            CONFIG_TARGETS+=("$TARGET_CONFIG/$name/")
        else
            CONFIG_NAMES+=("$name")
            CONFIG_SOURCES+=("$entry")
            CONFIG_TARGETS+=("$TARGET_CONFIG/$name")
        fi
    done
fi

print_section "\nConfiguration Files Found"
echo -e "${MUTED}Select which files to symlink (y/N):${RESET}"

SELECTED_INDICES=()

for i in "${!CONFIG_NAMES[@]}"; do
    name="${CONFIG_NAMES[i]}"
    dest="${CONFIG_TARGETS[i]}"
    printf "  ${BOLD}%s${RESET} ${MUTED}%s${RESET} ${PRIMARY}[y/N]${RESET}: " "$name" "$dest"
    read -n 1 -r reply
    echo
    if [[ "$reply" =~ ^[Yy]$ ]]; then
        SELECTED_INDICES+=("$i")
    fi
done

if [[ "${#SELECTED_INDICES[@]}" -eq 0 ]]; then
    print_error "\nNo configs selected. Exiting."
    exit 0
fi

print_section "\nSymlinking Configuration Files"

SYMLINKED=()
EXISTS=()
FAILED=()

for i in "${SELECTED_INDICES[@]}"; do
    src="${CONFIG_SOURCES[i]}"
    dest="${CONFIG_TARGETS[i]}"
    name="${CONFIG_NAMES[i]}"

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        EXISTS+=("$name -> $dest")
        continue
    fi

    ln -s "$src" "$dest" 2>/dev/null
    if [ $? -eq 0 ]; then
        SYMLINKED+=("$name -> $dest")
    else
        FAILED+=("$name -> $dest")
    fi
done

if [[ ${#SYMLINKED[@]} -gt 0 ]]; then
    echo -e "\n${SUCCESS}${BOLD}Successful:${RESET}"
    for entry in "${SYMLINKED[@]}"; do
        print_item "$entry"
    done
fi

if [[ ${#EXISTS[@]} -gt 0 ]]; then
    echo -e "\n${WARNING}${BOLD}Skipped (already exists):${RESET}"
    for entry in "${EXISTS[@]}"; do
        print_item "$entry"
    done
fi

if [[ ${#FAILED[@]} -gt 0 ]]; then
    echo -e "\n${ERROR}${BOLD}Failed:${RESET}"
    for entry in "${FAILED[@]}"; do
        print_item "$entry"
    done
fi

echo -e "\n${SUCCESS}${BOLD}Operation completed.${RESET}"
