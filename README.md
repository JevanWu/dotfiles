# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io). Covers zsh, Vim, IdeaVim (JetBrains), and VS Code.

## What's included

### zsh (`~/.zshrc`)

- [Oh-My-Zsh](https://ohmyz.sh) with [Powerlevel10k](https://github.com/romkatv/powerlevel10k) theme
- Plugins: `git`, `zsh-autosuggestions`, `zsh-syntax-highlighting`
- Runtime managers: rbenv, NVM (lazy-loaded), GVM, SDKMAN, Bun
- kubectl completion (cached for faster startup)
- Google Cloud SDK integration
- Directory aliases and Docker/kubectl shortcuts
- Machine-local secrets via `~/.zshrc.secrets` (not tracked in git)

### Vim (`~/.vimrc`, `~/vim/`)

- [vim-plug](https://github.com/junegunn/vim-plug) for plugin management
- [onedark](https://github.com/joshdick/onedark.vim) colorscheme
- Modular plugin files:
  - `plugins.vim` — NERDTree, fzf, vim-airline, vim-fugitive, EasyMotion, CtrlSF, and more
  - `ctags_plugins.vim` — gutentags + gutentags_plus for automatic tag generation
  - `ruby_plugins.vim` — vim-ruby, vim-rails, vim-bundler, vim-test
  - `js_plugins.vim` — JavaScript, JSX, TypeScript, TSX, and Node.js syntax support
- Custom key bindings (leader: `Space`)

### IdeaVim (`~/.ideavimrc`)

Modal editing for JetBrains IDEs with bindings for:

- Navigation: `Ctrl+P` (Go to File), `Ctrl+B` (Recent Files), `Ctrl+F` (Find in Path)
- Code: `Ctrl+]` (Go to Declaration), `gi` (Go to Implementation), `gs` (Go to Super)
- Debugging: `;b` (breakpoint), `;r` (resume), `;s` (step into), `;n` (step over)
- Formatting: `==` (Reformat Code), `leader+/` (toggle comment)
- Multi-cursor via [vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors)

### VS Code (`keybindings.json`)

Custom keyboard shortcuts for VS Code on macOS.

## Installation

1. [Install chezmoi](https://www.chezmoi.io/install/)
2. Apply the dotfiles:

```sh
chezmoi init https://github.com/jevanwu/dotfiles.git
chezmoi apply
```

### Machine-local secrets

Sensitive environment variables (API keys, tokens, etc.) go in `~/.zshrc.secrets` — this file is not tracked in git and is sourced automatically if it exists.

## Optional prerequisites

Each config section works independently. Install only what you need:

| Tool | Used by |
|------|---------|
| [Oh-My-Zsh](https://ohmyz.sh) | zsh |
| [Powerlevel10k](https://github.com/romkatv/powerlevel10k) | zsh |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | zsh |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | zsh |
| [rbenv](https://github.com/rbenv/rbenv) | zsh (Ruby) |
| [NVM](https://github.com/nvm-sh/nvm) | zsh (Node.js) |
| [GVM](https://github.com/moovweb/gvm) | zsh (Go) |
| [SDKMAN](https://sdkman.io) | zsh (Java) |
| [Bun](https://bun.sh) | zsh |
| [Google Cloud SDK](https://cloud.google.com/sdk) | zsh |
| [kubectl](https://kubernetes.io/docs/tasks/tools/) | zsh |
| [vim-plug](https://github.com/junegunn/vim-plug) | Vim |
| [IdeaVim](https://github.com/JetBrains/ideavim) | JetBrains IDEs |
