#!/bin/bash

# ncanrc - Dotfiles management script
# Replaces the Makefile with a pure shell script approach

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to display usage
usage() {
    echo -e "${BLUE}ncanrc - Dotfiles Management${NC}"
    echo ""
    echo "Usage: $0 <command>"
    clear
    echo ""
    echo "Commands:"
    echo -e "  ${GREEN}sym${NC}           - Create symlinks for configurations"
    echo -e "  ${GREEN}brew${NC}          - Install Homebrew and CLI packages (server-friendly)"
    echo -e "  ${GREEN}brew --with-casks${NC} - Install Homebrew with GUI applications"
    echo -e "  ${GREEN}install${NC}       - Install Oh My Zsh"
    echo -e "  ${GREEN}clean${NC}         - Remove all configurations"
    echo -e "  ${GREEN}backup${NC}        - Backup current configurations"
    echo -e "  ${GREEN}clear_backup${NC}  - Remove backup files"
    echo -e "  ${GREEN}load_backup${NC}   - Restore configurations from backup"
    echo -e "  ${GREEN}help${NC}          - Show this help message"
    echo ""
}

# Function to run a command with colored output
run_command() {
    local cmd_name=$1
    local script_name=$2
    shift 2  # Remove first two arguments, leaving any additional args
    
    echo -e "${BLUE}Running: ${cmd_name}${NC}"
    
    if [ -f "./scripts/${script_name}" ]; then
        ./scripts/${script_name} "$@"  # Pass remaining arguments to the script
        echo -e "${GREEN}✓ ${cmd_name} completed${NC}"
    else
        echo -e "${RED}✗ Script scripts/${script_name} not found${NC}"
        exit 1
    fi
}

# Main command handling
case "${1:-}" in
    "sym")
        run_command "Symlink configurations" "sym.sh"
        ;;
    "brew")
        shift  # Remove 'brew' from arguments
        run_command "Install Homebrew and packages" "brew.sh" "$@"
        ;;
    "install")
        run_command "Install Oh My Zsh" "install.sh"
        ;;
    "clean")
        run_command "Clean configurations" "clean.sh"
        ;;
    "backup")
        run_command "Backup configurations" "backup.sh"
        ;;
    "clear_backup")
        run_command "Clear backup files" "clear_backup.sh"
        ;;
    "load_backup")
        run_command "Load backup configurations" "load_backup.sh"
        ;;
    "help"|"-h"|"--help")
        usage
        ;;
    "")
        echo -e "${YELLOW}No command specified${NC}"
        echo ""
        usage
        exit 1
        ;;
    *)
        echo -e "${RED}Unknown command: $1${NC}"
        echo ""
        usage
        exit 1
        ;;
esac
