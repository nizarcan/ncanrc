#!/bin/bash

set -e  # Exit on error

# Function to create symlink with existence checking
create_symlink() {
    local source_path="$1"
    local target_path="$2"
    local config_name="$3"
    local check_type="$4"  # 'file' or 'dir'
    
    if [ "$check_type" = "file" ]; then
        if [ -L "$target_path" ] || [ -f "$target_path" ]; then
            echo "! $config_name configuration exists, skipping symlink"
            return 0
        fi
    elif [ "$check_type" = "dir" ]; then
        if [ -L "$target_path" ] || [ -d "$target_path" ]; then
            echo "! $config_name configuration exists, skipping symlink"
            return 0
        fi
    fi
    
    ln -s "$source_path" "$target_path"
    echo "✓ $config_name config symlinked"
}

# Function to handle utility script symlinks (with broken link detection)
create_utility_symlink() {
    local source_path="$1"
    local target_path="$2"
    local script_name="$3"
    
    if [ -L "$target_path" ]; then
        # Check if it's a broken symlink
        if ! [ -e "$target_path" ]; then
            echo "! Removing broken $script_name symlink"
            rm "$target_path"
            ln -s "$source_path" "$target_path"
            echo "✓ $script_name symlinked (updated)"
        else
            echo "! $script_name exists, skipping symlink"
        fi
    elif [ -f "$target_path" ]; then
        echo "! $script_name exists (regular file), skipping symlink"
    else
        ln -s "$source_path" "$target_path"
        echo "✓ $script_name symlinked"
    fi
}

echo "Setting up symbolic links for configurations..."

# Configuration symlinks
create_symlink "$(pwd)/config/nvim" "$HOME/.config/nvim" "Neovim" "dir"
create_symlink "$(pwd)/config/tmux/tmux.conf" "$HOME/.tmux.conf" "Tmux" "file"
create_symlink "$(pwd)/config/zsh/zshrc" "$HOME/.zshrc" "Zsh" "file"
create_symlink "$(pwd)/config/alacritty" "$HOME/.config/alacritty" "Alacritty" "dir"
create_symlink "$(pwd)/config/ghostty" "$HOME/.config/ghostty" "Ghostty" "dir"

# Utility script symlinks
create_utility_symlink "$(pwd)/utilities/tmux/tmux-session.sh" "/usr/local/bin/tmux-session" "Tmux session script"

echo "Symlink setup completed!"