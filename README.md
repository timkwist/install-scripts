# Terminal Setup Script

This repository contains a script that sets up an enhanced terminal environment with powerful CLI tools and productivity enhancements.

## Usage

Simply run the setup script:

```bash
./setup.sh
```

After running, restart your terminal or run:

```bash
source ~/.zshrc
```

## What It Does

The setup script:

1. Checks for zsh and oh-my-zsh installation
2. Creates a backup of your existing .zshrc
3. Installs Homebrew if not already installed
4. Allows selective installation of tool categories:
   - Core utilities (fzf, eza, bat, ripgrep, fd)
   - Navigation tools (tldr, direnv)
   - Development tools (httpie, tmux)
   - Git tools (lazygit, git-delta)
   - System monitoring (bottom, glances)
   - ZSH plugins (autosuggestions, syntax-highlighting)
   - Applications (rectangle)
5. Checks for Node.js/npm before installing npm packages
6. Configures FZF keybindings and completion
7. Installs global NPM tools (trash-cli)
8. Updates your `.zshrc` with necessary configurations
9. Adds useful ZSH plugins (git, brew, node, npm, fzf, history, macos, docker, pip, python, vscode, extract)
10. Sets a timestamp in your prompt
11. Safely adds aliases without overwriting existing ones

## New Features After Setup

Once the setup script has been run, you'll have access to these powerful features:

### Enhanced File Navigation and Management

- **fzf**: Fuzzy finder for files, command history, and more (CTRL+R, CTRL+T)
- **eza**: Modern replacement for `ls` with color-coding and git integration
- **bat**: Enhanced `cat` with syntax highlighting and git integration
- **fd**: Fast and user-friendly alternative to `find`
- **ripgrep**: Extremely fast text search tool (`rg`)
- **trash-cli**: Send files to trash instead of permanently deleting them

### Improved Terminal Experience

- **zsh-autosuggestions**: Fish-like command suggestions as you type
- **zsh-syntax-highlighting**: Syntax highlighting for shell commands
- **direnv**: Environment variables loader for different directories
- **rectangle**: Window management app for macOS
- **timestamp prompt**: Shows date and time in your command prompt

### Development Tools

- **httpie**: Modern, user-friendly HTTP client for the command line
- **lazygit**: Simple terminal UI for git commands
- **git-delta**: Enhanced syntax highlighting for git diffs
- **tmux**: Terminal multiplexer for managing multiple terminal sessions
- **bottom**: A graphical process/system monitor similar to htop
- **glances**: System monitoring tool with a web interface option

### ZSH Plugins

- **git**: Git integration and aliases
- **brew**: Homebrew commands and completion
- **node/npm**: Node.js and npm shortcuts
- **history**: Enhanced history management
- **macos**: macOS-specific commands and shortcuts
- **docker**: Docker commands and completion
- **pip/python**: Python development helpers
- **vscode**: Visual Studio Code integration
- **extract**: Extracts archived files with a single command

## Examples

```bash
# Fuzzy find files (press CTRL+T while typing a command)
vim <CTRL+T>

# Search command history (press CTRL+R)
<CTRL+R>

# Use enhanced ls replacement (aliases added automatically)
ls      # simple listing (eza)
ll      # detailed list (eza -l)
la      # show all files (eza -la)
lsd     # list with directories first
lt      # list sorted by size
ltr     # list sorted by modification time
lt1     # tree view, depth 1
lt2     # tree view, depth 2
lt3     # tree view, depth 3
lg      # list with git status

# View a file with syntax highlighting
bat filename.js

# Find files quickly
fd "pattern"

# Fast text search
rg "search pattern"

# Move files to trash instead of deleting
trash file.txt

# Fix a previous command typo
apt-get install python3

# Interactive git UI
lazygit

# Enhanced git diff view
git diff | delta

# Terminal multiplexer (split panes, multiple sessions)
tmux

# Interactive system monitor
bottom

# Web-based system monitoring
glances -w

# Enhanced HTTP client
http GET google.com

# Load environment variables from .envrc automatically
cd project-with-envrc # direnv loads variables

# TLDR pages - simplified man pages with examples
tldr tar
```

## Features

- 📋 **Selective Installation**: Choose which package groups to install
- 🔄 **Idempotent**: Can be run multiple times safely
- 🛡️ **Safe**: Backs up your .zshrc before making changes
- 🔍 **Smart Alias Management**: Doesn't override existing aliases
- ⚠️ **Error Handling**: Detailed error messages and recovery options
- 📝 **Detailed Summary**: Lists all changes made after completion

Enjoy your enhanced terminal experience!