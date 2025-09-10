#!/bin/bash

# If a directory is passed as an argument, use it as the selected directory
if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$((find ~/projects/work -mindepth 2 -maxdepth 2 -type d && find ~ ~/.config ~/projects/personal -mindepth 1 -maxdepth 1 -type d) | fzf)
fi

# If no directory is selected, exit
if [[ -z "$selected" ]]; then
    echo "No directory selected"
    exit 1
fi

# If tmux is not installed, exit
if ! command -v tmux &> /dev/null; then
    echo "Tmux is not installed"
    exit 1
fi

# Generate a session name based on the selected directory
selected_name=$(basename "$selected" | tr . _)

# If not in a tmux session, create one with the selected name
if [[ -z "$TMUX" ]]; then
    # If a session with the selected name already exists, attach to it
    if tmux has-session -t "$selected_name" 2> /dev/null; then
        tmux attach-session -t "$selected_name"
        exit 0
    fi
    # If not, create a new session with the selected name
    tmux new-session -s "$selected_name" -c "$selected"
    exit 0
else
    # If in a tmux session, create a new window with the selected directory
    if ! tmux has-session -t "$selected_name" 2> /dev/null; then
        tmux new-session -s "$selected_name" -c "$selected" -d
        tmux switch-client -t "$selected_name"
        exit 0
    fi
    # If a session with the selected name already exists, switch to it
    tmux switch-client -t "$selected_name"
    exit 0
fi

