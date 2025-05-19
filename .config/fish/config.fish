# Format man pages
set -x MANROFFOPT -c
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

function fish_greeting
    # fastfetch
end

set -U fish_prompt_pwd_dir_length 0

set -U fish_history_max_items 5000

# Aliases
alias cp "cp -i"
alias rm-rf "rm -rfi"
alias mv "mv -i"
alias clear "command clear; commandline -f clear-screen"

alias ld "eza -lhD --icons=auto"  # long list dirs
alias lt "eza --icons=auto --tree"  # list folder as tree
alias l "eza -lh --icons=auto"  # long list
alias ls "eza -1 --icons=auto"  # short list
alias ll "eza -lha --icons=auto --sort=name --group-directories-first"

alias y "yazi"

alias .. "cd .."
alias ... "cd ../.."

# Cleanup orphaned packages
alias cleanup "sudo pacman -Rns (pacman -Qtdq)"

# Get the error messages from journalctl
alias jctl "journalctl -p 3 -xb"

zoxide init fish | source

# Env Variables
set -Ux LANG en_US.UTF-8
set -Ux LC_ALL en_US.UTF-8
set -Ux CLANG_FORMAT_PATH "$HOME/.clang-format"
set -Ux STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"

# Transient Prompt
function starship_transient_prompt_func
    tput cuu1 # Moves up one line
    starship module character
end

function prompt_newline --on-event fish_postexec
    echo # Adds new line after each cmd
end

function starship_transient_rprompt_func
    starship module cmd_duration
end

starship init fish | source

enable_transience
