#!/bin/bash
set -eo pipefail

G='\033[0;32m' D='\033[0;90m' N='\033[0m'

ok()   { printf "  ${G}✓${N} %s\n" "$1"; }
info() { printf "  ${D}·${N} %s\n" "$1"; }

# Oh My Zsh
if [[ -d "$HOME/.oh-my-zsh" ]]; then
  ok "Oh My Zsh already installed"
else
  info "Installing Oh My Zsh..."
  RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  ok "Oh My Zsh installed"
fi

# TPM (Tmux Plugin Manager)
if [[ -d "$HOME/.tmux/plugins/tpm" ]]; then
  ok "TPM already installed"
else
  info "Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm" 2>/dev/null
  ok "TPM installed (run prefix+I in tmux to load plugins)"
fi
