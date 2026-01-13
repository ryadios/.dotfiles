#!/bin/bash
set -euo pipefail

START_TIME=$(date +%s.%N)

WALL_REPO="git@github.com:ryadios/.wallpaper.git"
WALL_CACHE="$HOME/.cache/wallpapers"
WALL_DST="$HOME/Pictures/Wallpapers/assets"

STOW_TARGETS=(
  ".config:$HOME/.config"
  ".home:$HOME"
  "bin:$HOME/.local/bin"
)

SYMLINKED=()
FAILED=()

if [ -t 1 ]; then
  C_INFO="\033[34m"
  C_OK="\033[32m"
  C_WARN="\033[33m"
  C_FAIL="\033[31m"
  C_FIN="\033[35m"
  C_HEAD="\033[36m"
  C_RESET="\033[0m"
else
  C_INFO="" C_OK="" C_WARN="" C_FAIL="" C_FIN="" C_HEAD="" C_RESET=""
fi

log()  { printf "%b[INFO]%b %s\n" "$C_INFO" "$C_RESET" "$1"; }
ok()   { printf "%b[OK]%b   %s\n" "$C_OK"   "$C_RESET" "$1"; }
warn() { printf "%b[WARN]%b %s\n" "$C_WARN" "$C_RESET" "$1"; }
fail() { printf "%b[FAIL]%b %s\n" "$C_FAIL" "$C_RESET" "$1"; }
fin()  { printf "%b[FINISHED]%b %s\n" "$C_FIN" "$C_RESET" "$1"; }

section() {
  printf "\n== %s ==\n" "$1"
}

printf "\n%bryadi .dotfiles%b\n" "$C_HEAD" "$C_RESET"

section "Dotfiles"

mkdir -p "$HOME/.config" "$HOME/.local/bin"

for entry in "${STOW_TARGETS[@]}"; do
  IFS=":" read -r src dst <<< "$entry"

  if stow "$src" -t "$dst" 2>/dev/null; then
    SYMLINKED+=("$src → $dst")
    ok "Stowed $src"
  else
    FAILED+=("$src → $dst")
    fail "Failed to stow $src"
  fi
done

read -rp $'\nImport wallpapers? [y/N]: ' ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
  section "Wallpapers"

  mkdir -p "$WALL_CACHE" "$WALL_DST"

  if [ -d "$WALL_CACHE/.git" ]; then
    log "Updating wallpaper repository"
    git -C "$WALL_CACHE" pull --ff-only
    ok "Wallpaper repository updated"
  else
    log "Cloning wallpaper repository"
    git clone "$WALL_REPO" "$WALL_CACHE"
    ok "Wallpaper repository cloned"
  fi

  log "Syncing wallpapers"
  rsync -a --delete "$WALL_CACHE/assets/" "$WALL_DST/"
  ok "Wallpapers installed"
else
  warn "Wallpaper import skipped"
fi

if [ "${#SYMLINKED[@]}" -gt 0 ] || [ "${#FAILED[@]}" -gt 0 ]; then
  section "Summary"
  printf "\n"
fi

if [ "${#SYMLINKED[@]}" -gt 0 ]; then
  printf "Symlinks Created:\n"
  for s in "${SYMLINKED[@]}"; do
    printf "  - %s\n" "$s"
  done
fi

if [ "${#FAILED[@]}" -gt 0 ]; then
  printf "\nFailures:\n"
  for f in "${FAILED[@]}"; do
    printf "  - %s\n" "$f"
  done
fi

END_TIME=$(date +%s.%N)
ELAPSED=$(printf "%.2f" "$(echo "$END_TIME - $START_TIME" | bc)")

printf "\n"
fin "Done in $ELAPSED sec"
