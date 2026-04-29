# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io). Covers zsh, Vim, IdeaVim (JetBrains), and VS Code.

## What's included

### zsh (`~/.zshrc`)

- [Starship](https://starship.rs) prompt
- Plugins: `zsh-autosuggestions`, `zsh-syntax-highlighting`, `zsh-history-substring-search`, `fzf-tab`, `forgit`
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

1. [Install Homebrew](https://brew.sh) (if not already installed)
2. [Install chezmoi](https://www.chezmoi.io/install/)
3. Apply the dotfiles:

```sh
chezmoi init https://github.com/jevanwu/dotfiles.git
chezmoi apply
```

4. Run the bootstrap script to install all required tools and zsh plugins:

```sh
~/.local/share/chezmoi/install.sh
```

5. Open a new shell (or run `exec zsh`) to load everything.

### What `install.sh` installs

| Tool | Purpose |
|------|---------|
| [starship](https://starship.rs) | Shell prompt |
| [bat](https://github.com/sharkdp/bat) | `cat` with syntax highlighting |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder |
| [tldr](https://tldr.sh) | Simplified man pages |
| [lazygit](https://github.com/jesseduffield/lazygit) | Terminal UI for git |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smarter `cd` |
| [forgit](https://github.com/wfxr/forgit) | Interactive git commands via fzf |
| [zsh-completions](https://github.com/zsh-users/zsh-completions) | Extra zsh completions |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Fish-style suggestions |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Command syntax highlighting |
| [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search) | History search with arrow keys |
| [fzf-tab](https://github.com/Aloxaf/fzf-tab) | fzf-powered tab completion |

### Machine-local secrets

Sensitive environment variables (API keys, tokens, etc.) go in `~/.zshrc.secrets` — this file is not tracked in git and is sourced automatically if it exists.

## Optional prerequisites

Install these manually as needed:

| Tool | Used by |
|------|---------|
| [rbenv](https://github.com/rbenv/rbenv) | zsh (Ruby) |
| [NVM](https://github.com/nvm-sh/nvm) | zsh (Node.js) |
| [GVM](https://github.com/moovweb/gvm) | zsh (Go) |
| [SDKMAN](https://sdkman.io) | zsh (Java) |
| [Bun](https://bun.sh) | zsh |
| [Google Cloud SDK](https://cloud.google.com/sdk) | zsh |
| [kubectl](https://kubernetes.io/docs/tasks/tools/) | zsh |
| [vim-plug](https://github.com/junegunn/vim-plug) | Vim |
| [IdeaVim](https://github.com/JetBrains/ideavim) | JetBrains IDEs |
