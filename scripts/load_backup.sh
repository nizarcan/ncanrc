#!/bin/bash

# This script is used to load the user's configs by copying them from a .bak file

# Function to restore config from backup
restore_backup() {
    local backup_path="$1"
    local target_path="$2"
    local config_name="$3"
    local type="$4"  # 'file' or 'dir'
    
    if [ "$type" = "file" ] && [ -f "$backup_path" ]; then
        cp "$backup_path" "$target_path"
        echo "✓ $config_name config restored"
    elif [ "$type" = "dir" ] && [ -d "$backup_path" ]; then
        rm -rf "$target_path" 2>/dev/null || true
        cp -r "$backup_path" "$target_path"
        echo "✓ $config_name config restored"
    else
        echo "! $config_name config backup not found"
    fi
}

echo "Restoring configurations from backup..."

# Restore configurations
restore_backup "$HOME/.config/nvim.bak" "$HOME/.config/nvim" "Neovim" "dir"
restore_backup "$HOME/.zshrc.bak" "$HOME/.zshrc" "Zsh" "file"
restore_backup "$HOME/.tmux.conf.bak" "$HOME/.tmux.conf" "Tmux" "file"
restore_backup "$HOME/.config/alacritty/alacritty.toml.bak" "$HOME/.config/alacritty/alacritty.toml" "Alacritty" "file"
restore_backup "$HOME/.config/ghostty.bak" "$HOME/.config/ghostty" "Ghostty" "dir"

echo "Backup restoration completed!"