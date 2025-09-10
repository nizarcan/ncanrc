# ncanrc

This repository contains a collection of configuration files, scripts.

## Table of Contents

- [Description](#description)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Description

The `ncanrc` repository holds various configuration files and scripts used for setting up and customizing tools and environments. It includes configurations for tools like `tmux`, `neovim`, and `zsh`, along with utility scripts and setup files.

## Usage

Use the `run.sh` script to manage your dotfiles and environment setup:

```bash
./run.sh <command>
```

### Available Commands

- `./run.sh sym` - Create symlinks for configurations
- `./run.sh brew` - Install Homebrew and CLI packages (server-friendly)
- `./run.sh brew --with-casks` - Install Homebrew with GUI applications  
- `./run.sh install` - Install Oh My Zsh
- `./run.sh clean` - Remove all configurations
- `./run.sh backup` - Backup current configurations
- `./run.sh clear_backup` - Remove backup files
- `./run.sh load_backup` - Restore configurations from backup
- `./run.sh help` - Show help message

### Directory Structure

- `scripts/`: Contains management scripts (`backup.sh`, `brew.sh`, `clean.sh`, `sym.sh`, etc.)
- `utilities/`: Contains utility scripts like `tmux-session.sh` that get linked to system paths
- `config/`: Holds configuration files for different tools such as `neovim`, `tmux`, and `zsh`
- `run.sh`: Main script that provides unified interface to all functionality

## Contributing

Contributions are welcome! If you find any issues or want to improve the configurations, feel free to open an issue or submit a pull request.

## License

The contents of this repository are licensed under the [MIT License](LICENSE).

