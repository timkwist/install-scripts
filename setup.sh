#!/bin/bash

echo "🔧 Starting terminal setup..."

# Error handling
handle_error() {
  local exit_code=$?
  echo "❌ Error occurred (exit code: $exit_code). Check the console output above for details."
  exit $exit_code
}

# Enable error trapping
set -e
trap handle_error ERR

# Config variables
ZSHRC="$HOME/.zshrc"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
BREW_BIN=$(command -v brew || true)

# Check if zsh is installed
if ! command -v zsh >/dev/null 2>&1; then
  echo "❌ zsh is not installed. Please install zsh first."
  echo "You can install zsh with: brew install zsh"
  exit 1
fi

# Check if oh-my-zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "❌ oh-my-zsh is not installed. Please install oh-my-zsh first."
  echo "You can install oh-my-zsh with: sh -c \"$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
  exit 1
fi

# Create backup of .zshrc if it exists
if [ -f "$ZSHRC" ]; then
  BACKUP_FILE="${ZSHRC}.bak.$(date +%Y%m%d_%H%M%S)"
  echo "📑 Creating backup of $ZSHRC at $BACKUP_FILE"
  cp "$ZSHRC" "$BACKUP_FILE"
fi

# -- Ensure Homebrew --
if [ -z "$BREW_BIN" ]; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Ask user if they want to install everything
read -p "📋 Install all package groups? (Y/n): " INSTALL_ALL
INSTALL_ALL=${INSTALL_ALL:-Y}

if [[ "$INSTALL_ALL" =~ ^[Yy]$ ]]; then
  INSTALL_CORE=Y
  INSTALL_NAV=Y
  INSTALL_DEV=Y
  INSTALL_GIT=Y
  INSTALL_SYS=Y
  INSTALL_ZSH=Y
  INSTALL_APPS=Y
else
  read -p "📦 Core utilities (fzf, eza, bat, ripgrep, fd) [Y/n]: " INSTALL_CORE
  INSTALL_CORE=${INSTALL_CORE:-Y}
  read -p "📦 Navigation tools (tldr, direnv) [Y/n]: " INSTALL_NAV
  INSTALL_NAV=${INSTALL_NAV:-Y}
  read -p "📦 Development tools (httpie, tmux) [Y/n]: " INSTALL_DEV
  INSTALL_DEV=${INSTALL_DEV:-Y}
  read -p "📦 Git tools (lazygit, git-delta) [Y/n]: " INSTALL_GIT
  INSTALL_GIT=${INSTALL_GIT:-Y}
  read -p "📦 System monitoring (bottom, glances) [Y/n]: " INSTALL_SYS
  INSTALL_SYS=${INSTALL_SYS:-Y}
  read -p "📦 ZSH plugins (autosuggestions, syntax-highlighting) [Y/n]: " INSTALL_ZSH
  INSTALL_ZSH=${INSTALL_ZSH:-Y}
  read -p "📦 Applications (rectangle) [Y/n]: " INSTALL_APPS
  INSTALL_APPS=${INSTALL_APPS:-Y}
fi

echo "🍺 Installing selected CLI tools..."

# Build package list based on user selection
PACKAGES=""
if [[ "$INSTALL_CORE" =~ ^[Yy] ]]; then PACKAGES="$PACKAGES fzf eza bat ripgrep fd"; fi
if [[ "$INSTALL_NAV" =~ ^[Yy] ]]; then PACKAGES="$PACKAGES tldr direnv"; fi
if [[ "$INSTALL_DEV" =~ ^[Yy] ]]; then PACKAGES="$PACKAGES httpie tmux"; fi
if [[ "$INSTALL_GIT" =~ ^[Yy] ]]; then PACKAGES="$PACKAGES lazygit git-delta"; fi
if [[ "$INSTALL_SYS" =~ ^[Yy] ]]; then PACKAGES="$PACKAGES bottom glances"; fi
if [[ "$INSTALL_ZSH" =~ ^[Yy] ]]; then PACKAGES="$PACKAGES zsh-autosuggestions zsh-syntax-highlighting"; fi
if [[ "$INSTALL_APPS" =~ ^[Yy] ]]; then PACKAGES="$PACKAGES rectangle"; fi

# Install selected packages
if [ -n "$PACKAGES" ]; then
  echo "Installing: $PACKAGES"
  if ! brew install $PACKAGES; then
    echo "⚠️ Some packages may have failed to install. Check the output above."
    echo "You can try installing them individually if needed."
  fi
else
  echo "No packages selected for installation."
fi

# -- fzf keybindings and completion --
if [[ "$INSTALL_CORE" =~ ^[Yy] ]] || [[ -z "$INSTALL_CORE" ]]; then
  if [ ! -f "$HOME/.fzf.zsh" ] && command -v fzf >/dev/null 2>&1; then
    echo "⚙️ Running fzf install script..."
    if [ -f "$(brew --prefix)/opt/fzf/install" ]; then
      "$(brew --prefix)/opt/fzf/install" --all --no-bash --no-fish
    else
      echo "⚠️ fzf install script not found, skipping keybindings setup."
    fi
  fi
fi

echo "📦 Checking for Node.js and npm..."
if ! command -v npm >/dev/null 2>&1; then
  echo "❌ npm is not installed. Please install Node.js/npm first."
  echo "You can install Node.js with: brew install node"
  exit 1
fi

echo "📦 Installing global npm tools..."
# Check if trash-cli is already installed
if ! command -v trash >/dev/null 2>&1; then
  echo "Installing trash-cli globally..."
  npm install --global trash-cli
else
  echo "trash-cli is already installed."
fi

# -- Add to .zshrc safely --
echo "📝 Updating $ZSHRC..."

add_if_missing() {
  local LINE="$1"
  grep -qxF "$LINE" "$ZSHRC" || echo "$LINE" >> "$ZSHRC"
}

# npm bin
add_if_missing "export PATH=\$PATH:\$(npm bin -g)"

# direnv
add_if_missing 'eval "$(direnv hook zsh)"'

# Set prompt to include timestamp
add_if_missing "PROMPT='%{\$fg[yellow]%}[%D{%f/%m/%y} %D{%L:%M:%S}] '\$PROMPT"

# fzf
add_if_missing '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh'

# zsh plugin sources
if [[ "$INSTALL_ZSH" =~ ^[Yy] ]] || [[ -z "$INSTALL_ZSH" ]]; then
  if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    add_if_missing "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  fi
  
  if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    add_if_missing "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  fi
fi

# -- Add plugins to the plugin list --
update_plugins() {
  local REQUIRED_PLUGINS=(git brew node npm fzf history macos docker pip python vscode extract zsh-autosuggestions zsh-syntax-highlighting)
  if grep -q '^plugins=' "$ZSHRC"; then
    echo "🔁 Merging plugins list..."
    local CURRENT_PLUGINS=$(grep '^plugins=' "$ZSHRC" | sed -E 's/plugins=\((.*)\)/\1/' | tr -d '\n')
    for plugin in "${REQUIRED_PLUGINS[@]}"; do
      if [[ ! $CURRENT_PLUGINS =~ $plugin ]]; then
        CURRENT_PLUGINS="$CURRENT_PLUGINS $plugin"
      fi
    done
    CURRENT_PLUGINS=$(echo "$CURRENT_PLUGINS" | xargs) # trim
    sed -i '' "s/^plugins=(.*)/plugins=($CURRENT_PLUGINS)/" "$ZSHRC"
  else
    echo "plugins=(${REQUIRED_PLUGINS[*]})" >> "$ZSHRC"
  fi
}

update_plugins

# -- Add eza aliases --
echo "📎 Adding eza aliases..."

# Function to check if an alias already exists with a different definition
alias_exists_with_different_def() {
  local alias_name=$1
  local expected_def=$2
  
  # Check if the alias exists
  if alias $alias_name 2>/dev/null >/dev/null; then
    # Get current definition
    local current_def=$(alias $alias_name | cut -d "'" -f 2)
    # Return true (0) if definitions are different
    if [ "$current_def" != "$expected_def" ]; then
      return 0
    fi
  fi
  return 1
}

# Function to add alias if it doesn't conflict
add_alias_if_safe() {
  local alias_name=$1
  local alias_def=$2
  
  if alias_exists_with_different_def "$alias_name" "$alias_def"; then
    echo "⚠️ Warning: alias '$alias_name' already exists with a different definition."
    echo "   Skipping this alias to avoid conflicts."
  else
    add_if_missing "alias $alias_name='$alias_def'"
  fi
}

add_if_missing "# eza aliases (ls replacement)"
add_alias_if_safe "ls" "eza"
add_alias_if_safe "ll" "eza -l"
add_alias_if_safe "la" "eza -la"
add_alias_if_safe "lsd" "eza -la --group-directories-first"
add_alias_if_safe "lt" "eza -la --sort=size --reverse"
add_alias_if_safe "ltr" "eza -la --sort=modified --reverse"
add_alias_if_safe "lt1" "eza --tree --level=1"
add_alias_if_safe "lt2" "eza --tree --level=2"
add_alias_if_safe "lt3" "eza --tree --level=3"
add_alias_if_safe "lg" "eza -la --git"

# Success message and next steps
echo "✅ Setup complete!"
echo "ℹ️  Restart your terminal or run: source ~/.zshrc"

# Log what was done
echo ""
echo "📝 Summary of changes:"
[ -n "$PACKAGES" ] && echo "  - Installed: $PACKAGES"
[ -f "$BACKUP_FILE" ] && echo "  - Created backup of .zshrc: $BACKUP_FILE"
echo "  - Updated .zshrc with new configurations"
if [[ "$INSTALL_CORE" =~ ^[Yy] ]]; then 
  echo "  - Added file navigation tools (run 'tldr fzf' for examples)"
fi
echo ""
echo "If you encounter any issues, restore your backup .zshrc with:"
echo "  cp \"$BACKUP_FILE\" \"$ZSHRC\""
