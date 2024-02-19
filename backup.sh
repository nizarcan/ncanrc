#!/bin/bash

# This script is used to backup the user's configs by copying them to a .bak file

# Neovim config
cp ~/.config/nvim ~/.config/nvim.bak

# Zsh config
cp ~/.zshrc ~/.zshrc.bak

# Alacritty config
cp ~/.config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml.bak

# Tmux config
cp ~/.tmux.conf ~/.tmux.conf.bak

