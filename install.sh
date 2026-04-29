#!/usr/bin/env bash
set -euo pipefail

# Bootstrap script — installs all tools and zsh plugins required by .zshrc via Homebrew.
# Run once after `chezmoi apply` on a new machine.

command -v brew >/dev/null 2>&1 || {
  echo "Homebrew not found. Install it first: https://brew.sh"
  exit 1
}

echo "==> Installing CLI tools..."
brew install \
  starship \
  bat \
  fzf \
  tldr \
  lazygit \
  zoxide \
  forgit

echo "==> Installing zsh plugins..."
brew install \
  zsh-completions \
  zsh-autosuggestions \
  zsh-syntax-highlighting \
  zsh-history-substring-search

brew tap Aloxaf/fzf-tab
brew install fzf-tab

echo ""
echo "All done. Open a new shell (or run: exec zsh) to load everything."
