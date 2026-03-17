#!/bin/bash
set -eo pipefail

G='\033[0;32m' Y='\033[1;33m' W='\033[1;37m' D='\033[0;90m' N='\033[0m'

ok()   { printf "  ${G}✓${N} %s\n" "$1"; }
warn() { printf "  ${Y}!${N} %s\n" "$1"; }
info() { printf "  ${D}·${N} %s\n" "$1"; }

_install() {
  local pkg="$1"
  if brew list "$pkg" &>/dev/null; then
    ok "$pkg"
  else
    info "Installing $pkg..."
    brew install "$pkg" 2>/dev/null && ok "$pkg" || warn "Failed: $pkg"
  fi
}

_install_cask() {
  local pkg="$1"
  if brew list --cask "$pkg" &>/dev/null; then
    ok "$pkg"
  else
    info "Installing $pkg..."
    brew install --cask "$pkg" 2>/dev/null && ok "$pkg" || warn "Failed: $pkg"
  fi
}

install_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    ok "Homebrew already installed"
    return
  fi

  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  ok "Homebrew installed"
}

install_languages() {
  printf "\n  ${W}Languages${N}\n"
  local pkgs=(git go python@3.12 python@3.13 node typescript rust bun)
  for pkg in "${pkgs[@]}"; do _install "$pkg"; done
}

install_tools() {
  printf "\n  ${W}CLI Tools${N}\n"
  local pkgs=(tree fzf ripgrep jq neovim tmux httpie difftastic)
  for pkg in "${pkgs[@]}"; do _install "$pkg"; done
}

install_services() {
  printf "\n  ${W}macOS Services${N}\n"

  # Tap repositories
  for tap in FelixKratz/formulae koekeishiya/formulae nikitabobko/tap; do
    brew tap "$tap" 2>/dev/null || true
  done

  for pkg in sketchybar skhd borders; do _install "$pkg"; done
  _install_cask "aerospace"
}

install_casks() {
  printf "\n  ${W}GUI Applications${N}\n"
  local pkgs=(
    ghostty alacritty
    arc notion raycast slack spotify whatsapp
    obsidian zed
    font-jetbrains-mono-nerd-font
  )
  for pkg in "${pkgs[@]}"; do _install_cask "$pkg"; done
}

# ── Parse args ────────────────────────────────────────────────────────────

INSTALL_CASKS=false
while [[ $# -gt 0 ]]; do
  case $1 in
    --with-casks) INSTALL_CASKS=true; shift ;;
    --help|-h) echo "Usage: brew.sh [--with-casks]"; exit 0 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

# ── Main ──────────────────────────────────────────────────────────────────

printf "\n  ${W}Homebrew Packages${N}\n"

install_homebrew
install_languages
install_tools
install_services

if [[ "$INSTALL_CASKS" == true ]]; then
  install_casks
else
  info "Skipping GUI apps (use --with-casks)"
fi

echo ""
ok "Package installation complete"
