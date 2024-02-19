#!/bin/bash

# This script is used to load the user's configs by copying them from a .bak file

# Neovim config
if [ -f ~/.config/nvim.bak ]; then
    cp ~/.config/nvim.bak ~/.config/nvim
else
    echo "Neovim config backup not found"
fi

# Zsh config
if [ -f ~/.zshrc.bak ]; then
    cp ~/.zshrc.bak ~/.zshrc
else
    echo "Zsh config backup not found"
fi

# Tmux config
if [ -f ~/.tmux.conf.bak ]; then
    cp ~/.tmux.conf.bak ~/.tmux.conf
else
    echo "Tmux config backup not found"
fi

# Alacritty config
if [ -f ~/.config/alacritty/alacritty.toml.bak ]; then
    cp ~/.config/alacritty/alacritty.toml.bak ~/.config/alacritty/alacritty.toml
else
    echo "Alacritty config backup not found"
fi

