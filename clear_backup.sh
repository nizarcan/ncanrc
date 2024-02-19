#!/bin/bash

# This script is used to clear the user's configs by removing the .bak files

# Neovim config
if [ -f ~/.config/nvim.bak ]; then
    rm ~/.config/nvim.bak
else
    echo "Neovim config backup not found"
fi

# Zsh config
if [ -f ~/.zshrc.bak ]; then
    rm ~/.zshrc.bak
else
    echo "Zsh config backup not found"
fi

# Tmux config
if [ -f ~/.tmux.conf.bak ]; then
    rm ~/.tmux.conf.bak
else
    echo "Tmux config backup not found"
fi

# Alacritty config
if [ -f ~/.config/alacritty/alacritty.toml.bak ]; then
    rm ~/.config/alacritty/alacritty.toml.bak
else
    echo "Alacritty config backup not found"
fi

