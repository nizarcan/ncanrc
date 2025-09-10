#!/bin/bash

# This script is used to clear the user's configs by removing the .bak files

# Function to remove backup files
clear_backup() {
    local backup_path="$1"
    local config_name="$2"
    local type="$3"  # 'file' or 'dir'
    
    if [ "$type" = "file" ] && [ -f "$backup_path" ]; then
        rm "$backup_path"
        echo "✓ $config_name backup removed"
    elif [ "$type" = "dir" ] && [ -d "$backup_path" ]; then
        rm -rf "$backup_path"
        echo "✓ $config_name backup removed"
    else
        echo "! $config_name config backup not found"
    fi
}

echo "Removing backup files..."

# Remove backup files
clear_backup "$HOME/.config/nvim.bak" "Neovim" "dir"
clear_backup "$HOME/.zshrc.bak" "Zsh" "file"
clear_backup "$HOME/.tmux.conf.bak" "Tmux" "file"
clear_backup "$HOME/.config/alacritty/alacritty.toml.bak" "Alacritty" "file"
clear_backup "$HOME/.config/ghostty.bak" "Ghostty" "dir"

echo "Backup cleanup completed!"