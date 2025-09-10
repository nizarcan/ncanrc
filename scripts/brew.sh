#!/bin/bash

set -e  # Exit on error

# Function to install Homebrew if not present
install_homebrew() {
    if ! command -v brew >/dev/null 2>&1; then
        echo "📦 Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Set up Homebrew in PATH for current session
        if [[ -f "/opt/homebrew/bin/brew" ]]; then
            # Apple Silicon Mac
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ -f "/usr/local/bin/brew" ]]; then
            # Intel Mac
            echo 'eval "$(/usr/local/bin/brew shellenv)"' >> "$HOME/.zprofile" 
            eval "$(/usr/local/bin/brew shellenv)"
        fi
        
        echo "✓ Homebrew installed successfully"
    else
        echo "✓ Homebrew already installed"
    fi
}

# Function to install programming languages
install_languages() {
    echo "🔧 Installing programming languages..."
    
    local languages=(
        "git"
        "go" 
        "python@3.8"
        "python@3.9"
        "python@3.10"
        "python@3.11"
        "python@3.12"
        "node"
        "typescript"
        "rust"
    )
    
    for lang in "${languages[@]}"; do
        echo "  Installing $lang..."
        brew install "$lang" || echo "  ⚠️  Failed to install $lang"
    done
    
    echo "✓ Programming languages installation completed"
}

# Function to install CLI tools
install_tools() {
    echo "🛠️  Installing CLI tools..."
    
    local tools=(
        "tree"
        "fzf"
        "ripgrep"
        "jq"
        "neovim"
        "tmux"
        "httpie"
    )
    
    for tool in "${tools[@]}"; do
        echo "  Installing $tool..."
        brew install "$tool" || echo "  ⚠️  Failed to install $tool"
    done
    
    echo "✓ CLI tools installation completed"
}

# Function to install GUI applications (casks)
install_casks() {
    echo "🖥️  Installing GUI applications..."
    
    # Add font tap first
    brew tap homebrew/cask-fonts || echo "  ⚠️  Failed to tap cask-fonts"
    
    local casks=(
        "alacritty"
        "notion"
        "raycast"
        "slack" 
        "spotify"
        "whatsapp"
        "font-jetbrains-mono-nerd-font"
    )
    
    for cask in "${casks[@]}"; do
        echo "  Installing $cask..."
        brew install --cask "$cask" || echo "  ⚠️  Failed to install $cask"
    done
    
    echo "✓ GUI applications installation completed"
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --with-casks  Install GUI applications (for desktop environments)"
    echo "  --help, -h    Show this help message"
    echo ""
    echo "Default behavior installs only CLI tools and languages (ideal for servers)"
}

# Parse command line arguments
INSTALL_CASKS=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --with-casks)
            INSTALL_CASKS=true
            shift
            ;;
        --help|-h)
            show_usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

# Main installation process
echo "🍺 Starting Homebrew package installation..."

install_homebrew
install_languages  
install_tools

if [[ "$INSTALL_CASKS" == "true" ]]; then
    install_casks
else
    echo "🚫 Skipping GUI applications (use --with-casks to install them)"
fi

echo ""
echo "🎉 Homebrew setup completed!"
echo "   Run 'brew doctor' to check for any issues"