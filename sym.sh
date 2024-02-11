#!/bin/bash

# Symlink My Neovim Config #
if test -f ~/.config/nvim/init.lua; then
    echo "NVim Configuration Exists, Not Creating Symlink"
else
    ln -s $(pwd)/config/nvim ~/.config/nvim
fi

# Symlink My Tmux Config #
if test -f ~/.tmux.conf; then
    echo "Tmux Configuration Exists, Not Creating Symlink"
else
    ln -s $(pwd)/config/tmux/tmux.conf ~/.tmux.conf
fi

# Symlink My Zsh Config #
if test -f ~/.zshrc; then
    echo "Zsh Configuration Exists, Not Creating Symlink"
else
    ln -s $(pwd)/config/zsh/zshrc ~/.zshrc
fi

# Symlink Tmux Session Script #
if test -f /usr/local/bin/tmux-session; then
    echo "Tmux Session Script Exists, Not Creating Symlink"
else
    ln -s $(pwd)/bin/tmux/tmux-session.sh /usr/local/bin/tmux-session
fi

