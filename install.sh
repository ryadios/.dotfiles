#!/bin/bash

[ -d "$HOME/.config" ] || mkdir -p "$HOME/.config"
stow .config -t ~/.config
stow .home -t ~
stow bin -t ~/.local/bin
