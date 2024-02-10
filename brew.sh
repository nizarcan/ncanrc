#!/bin/bash

#==================#
# Install Homebrew #
#==================#
if test ! $(which brew); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> /Users/$USER/.zprofile
    eval $(/opt/homebrew/bin/brew shellenv)
fi

#==========================#
# Install My Brew Packages #
#==========================#

# Programming Languages #
brew install git
brew install go
brew install python@3.8 python@3.9 python@3.10 python@3.11 python@3.12
brew install node
brew install typescript
brew install rust
brew install make

# Tools #
brew install tree
brew install fzf
brew install ripgrep
brew install jq
brew install neovim
brew install tmux

# Apps #
brew install --cask iterm2
brew install --cask notion
brew install --cask raycast
brew install --cask slack
brew install --cask spotify
brew install --cask whatsapp

# Fonts #
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font

