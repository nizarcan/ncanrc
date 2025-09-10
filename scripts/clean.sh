#!/bin/bash

# Remove all configuration files and symlinks

# Function to remove configuration files/directories
remove_config() {
    local target_path="$1"
    local config_name="$2"
    local type="$3"  # 'file' or 'dir'
    
    if [ "$type" = "file" ] && ([ -L "$target_path" ] || [ -f "$target_path" ]); then
        rm -rf "$target_path"
        echo "✓ $config_name configuration removed"
    elif [ "$type" = "dir" ] && ([ -L "$target_path" ] || [ -d "$target_path" ]); then
        rm -rf "$target_path"
        echo "✓ $config_name configuration removed"
    else
        echo "! $config_name configuration not found"
    fi
}

echo "Removing all configurations..."

# Remove configuration files and directories
remove_config "$HOME/.config/nvim" "Neovim" "dir"
remove_config "$HOME/.tmux.conf" "Tmux" "file"
remove_config "$HOME/.zshrc" "Zsh" "file"
remove_config "$HOME/.config/alacritty" "Alacritty" "dir"
remove_config "$HOME/.config/ghostty" "Ghostty" "dir"
remove_config "/usr/local/bin/tmux-session" "Tmux session script" "file"

echo "Configuration cleanup completed!"