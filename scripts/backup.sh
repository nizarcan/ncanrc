#!/bin/bash

# This script is used to backup the user's configs by copying them to a .bak file

set -e  # Exit on error

# Function to backup a config file or directory
backup_config() {
    local source_path="$1"
    local backup_path="$2"
    local config_name="$3"
    local type="$4"  # 'file' or 'dir'
    
    if [ -L "$source_path" ]; then
        echo "! $config_name config is a symlink, skipping backup"
        return 0
    fi
    
    if [ "$type" = "file" ] && [ -f "$source_path" ]; then
        cp "$source_path" "$backup_path"
        echo "✓ $config_name config backed up"
    elif [ "$type" = "dir" ] && [ -d "$source_path" ]; then
        cp -r "$source_path" "$backup_path"
        echo "✓ $config_name config backed up"
    else
        echo "! $config_name config not found, skipping backup"
    fi
}

echo "Creating backups of existing configurations..."

# Backup configurations
backup_config "$HOME/.config/nvim" "$HOME/.config/nvim.bak" "Neovim" "dir"
backup_config "$HOME/.zshrc" "$HOME/.zshrc.bak" "Zsh" "file"
backup_config "$HOME/.config/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml.bak" "Alacritty" "file"
backup_config "$HOME/.tmux.conf" "$HOME/.tmux.conf.bak" "Tmux" "file"
backup_config "$HOME/.config/ghostty" "$HOME/.config/ghostty.bak" "Ghostty" "dir"

echo "Backup completed!"