#!/bin/bash

# Syslink My Neovim Config #
if test -f ~/.config/nvim/init.lua; then
    echo "NVim Configuration Exists, Not Creating Symlink"
else
    ln -s $(pwd)/config/nvim ~/.config/nvim
fi

# Syslink My Tmux Config #
if test -f ~/.tmux.conf; then
    echo "Tmux Configuration Exists, Not Creating Symlink"
else
    ln -s $(pwd)/config/tmux/.tmux.conf ~/.tmux.conf
fi

# Syslink My Zsh Config #
if test -f ~/.zshrc; then
    echo "Zsh Configuration Exists, Not Creating Symlink"
else
    ln -s $(pwd)/config/zsh/.zshrc ~/.zshrc
fi
