#!/bin/bash

set -e

echo "Installing core apps via Homebrew and direct downloads..."

# Install Homebrew if not installed
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install GUI apps
brew install --cask rectangle sublime-text iterm2 slack

# Install oh-my-zsh
echo "Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install fonts
echo "Installing Fira Code and Powerline fonts..."
brew tap homebrew/cask-fonts
brew install --cask font-fira-code font-fira-mono font-hack-nerd-font

# Install iterm2-snazzy theme
echo "Installing iTerm2 Snazzy theme..."
git clone https://github.com/sindresorhus/iterm2-snazzy.git "$HOME/iterm2-snazzy"

# Install Pure prompt
echo "Installing Pure prompt..."
npm install --global pure-prompt

# Add Pure prompt to .zshrc
ZSHRC="$HOME/.zshrc"
if ! grep -q "prompt pure" "$ZSHRC"; then
  echo -e "\n# Pure prompt setup" >> "$ZSHRC"
  echo "ZSH_THEME=\"\"" >> "$ZSHRC"
  echo "autoload -U promptinit; promptinit" >> "$ZSHRC"
  echo "prompt pure" >> "$ZSHRC"
fi

# Install z (directory jumper)
echo "Installing z (jump tool)..."
brew install z

# Install zsh plugins
echo "Installing zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Installing zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install pygments for colorized cat
echo "Installing pygments..."
pip3 install --user pygments

# Install trash-cli
echo "Installing trash-cli..."
npm install --global trash-cli

# Update plugins in .zshrc
echo "Updating plugins list in .zshrc..."
PLUGINS="plugins=(
  git
  brew
  common-aliases
  node
  npm
  rand-quote
  sudo
  yarn
  z
  colored-man-pages
  colorize
  cp
  zsh-syntax-highlighting
  zsh-autosuggestions
  timer
)"
if grep -q "plugins=" "$ZSHRC"; then
  sed -i '' "/^plugins=/,/)/c\\
$PLUGINS
" "$ZSHRC"
else
  echo -e "\n$PLUGINS" >> "$ZSHRC"
fi

echo "Setup complete! Please:"
echo "- Manually set iTerm2 theme to Snazzy: Preferences > Profiles > Color Presets"
echo "- Set font in iTerm2: Preferences > Profiles > Text"
echo "  - Font: Fira Code 14pt with Ligatures"
echo "  - Non-ASCII Font: Fira Mono 14pt with Ligatures"
echo "- Restart your terminal or run: source ~/.zshrc"

echo "Optional:"
echo "- Try https://starship.rs/ or https://github.com/denysdovhan/spaceship-prompt for other prompts"
