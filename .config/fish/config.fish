# Environment variables
set --global --export EDITOR nvim
set --global --export VISUAL nvim
set --global --export LANG en_US.UTF-8
set --global --export LC_ALL en_US.UTF-8
set --global --export CHROME_PATH /usr/bin/helium-browser

# Shell settings
set --global fish_greeting

if not functions -q __fish_native_cd
    functions --copy cd __fish_native_cd
end

# Aliases
abbr --add --global .. 'cd ..'
abbr --add --global ... 'cd ../..'
alias ll 'eza --icons --group-directories-first -l -a'
alias z cd
alias jump zi
alias zls 'zoxide query --list'
alias update '$HOME/.config/waybar/bin/update up'

# Functions
function ls --wraps eza --description 'List files with eza'
    eza --icons --group-directories-first $argv
end

function y --wraps yazi --description 'Open yazi and change directory on exit'
    set -l tmp (mktemp -t yazi-cwd.XXXXXX)
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and test -n "$cwd"; and test "$cwd" != "$PWD"
        __fish_native_cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

function fd --description 'Find and enter a directory'
    if not command -sq fzf
        echo 'fzf is not installed.' >&2
        return 127
    end

    set -l selected (
        command find "$HOME" \
            \( -path "$HOME/.cache" -o -path "$HOME/.git" -o -path '*/node_modules' \) -prune \
            -o -type d -print 2>/dev/null |
        fzf --height=40% --layout=reverse --border \
            --preview 'eza --tree --level=2 --icons=auto --color=always {}'
    )

    test -n "$selected"; or return 130
    __fish_native_cd -- "$selected"
end

function ff --description 'Find and open a file or directory'
    if not command -sq fzf
        echo 'fzf is not installed.' >&2
        return 127
    end

    set -l selected (
        command find . \
            \( -path './.git' -o -path '*/node_modules' \) -prune \
            -o -print 2>/dev/null |
        fzf --height=40% --layout=reverse --border \
            --preview 'if test -d {}; eza --tree --level=2 --icons=auto --color=always {}; else bat --style=numbers --color=always --line-range=:200 {}; end'
    )

    test -n "$selected"; or return 130

    if test -d "$selected"
        __fish_native_cd -- "$selected"
    else if string match -q -r '\.(c|cc|cpp|h|hh|hpp|lua|py|rs|sh|toml|ts|tsx|js|jsx|json|yaml|yml)$' -- "$selected"
        nvim -- "$selected"
    else
        xdg-open "$selected" >/dev/null 2>&1 &
    end
end

function cd --description 'Change directory or jump with zoxide'
    if test (count $argv) -eq 0
        __fish_native_cd
        return $status
    end

    if test (count $argv) -ne 1
        __fish_native_cd $argv
        return $status
    end

    set -l target $argv[1]
    if test "$target" = -
        __fish_native_cd $argv
        return $status
    end

    if test -d "$target"
        __fish_native_cd -- "$target"
        return $status
    end

    if not command -sq zoxide
        echo "cd: '$target' is not a directory and zoxide is not installed." >&2
        return 127
    end

    set -l matches (command zoxide query --list -- $argv 2>/dev/null)
    if test (count $matches) -eq 0
        echo "cd: no matching directory for '$target'." >&2
        return 1
    end

    if test (count $matches) -gt 1
        set target (
            printf '%s\n' $matches |
            fzf --height=40% --layout=reverse --border \
                --preview 'eza --tree --level=2 --icons=auto --color=always {}'
        )
        test -n "$target"; or return 130
    else
        set target $matches[1]
    end

    __fish_native_cd -- "$target"
end

function zi --description 'Interactively jump with zoxide'
    set -l target (command zoxide query --interactive -- $argv 2>/dev/null)
    test -n "$target"; or return 130
    __fish_native_cd -- "$target"
end

function za --description 'Add the current directory to zoxide'
    command zoxide add "$PWD"
end

function zr --description 'Remove a directory from zoxide'
    if test (count $argv) -gt 0
        command zoxide remove $argv
        return $status
    end

    set -l target (command zoxide query --interactive 2>/dev/null)
    test -n "$target"; or return 130
    command zoxide remove -- "$target"
end

function ze --description 'Browse and edit the zoxide database'
    set -l result (
        command zoxide query --list --score 2>/dev/null |
        fzf --height=60% --layout=reverse --border --expect=ctrl-d
    )
    test (count $result) -ge 2; or return 130

    set -l action $result[1]
    set -l target (string replace -r '^[[:space:]]*[^[:space:]]+[[:space:]]+' '' -- "$result[2]")
    test -n "$target"; or return 1

    if test "$action" = ctrl-d
        command zoxide remove -- "$target"
    else
        __fish_native_cd -- "$target"
    end
end

function ocd --description 'Change directory with fish native behavior'
    __fish_native_cd $argv
end

function zcd --description 'Force an interactive zoxide jump'
    zi $argv
end

function cleanup --description 'Remove orphaned Arch packages'
    if not command -sq pacman
        echo 'pacman is not installed.' >&2
        return 127
    end

    set -l orphans (command pacman -Qtdq 2>/dev/null)
    if test (count $orphans) -eq 0
        echo 'No orphan packages found.'
        return 0
    end

    sudo pacman -Rns $orphans
end

function starship_transient_prompt_func
    starship module character
end

function prompt_newline --on-event fish_postexec --on-event fish_posterror
    echo
end

# Key bindings
bind \cf 'ff; commandline -f repaint'
bind \cg 'fd; commandline -f repaint'
bind \ck 'sesh picker'

# Path
set --global --export BUN_INSTALL "$HOME/.bun"
set --global PATH (string match --invert -- "$BUN_INSTALL/bin" $PATH)
fish_add_path --path "$BUN_INSTALL/bin"

if status is-interactive
    # Interactive session
    fish_config theme choose tokyonight-night
    if command -sq atuin
        atuin init fish | source
    end
    starship init fish | source
    zoxide init --cmd j fish | source
    enable_transience
    kotofetch
end
