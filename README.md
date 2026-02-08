# Neovim config (Lua + lazy.nvim)

This is my personal Neovim setup, managed with **[lazy.nvim](https://github.com/folke/lazy.nvim)**.

- **Leader key**: `<Space>`
- **Plugin specs**: `lua/plugins/*.lua`
- **Plugin entrypoint**: `lua/plugins.lua`

## Installation guide

### Prerequisites

- **Neovim** (recent version recommended)
- **git**
- Optional but recommended:
  - **lazygit** (for the LazyGit UI)
  - **gh** (GitHub CLI, used by LazyGit custom commands)
  - **fzf** + **ripgrep** (best experience for `fzf-lua`)
  - **delta** (optional; nicer git diff pager in LazyGit. If not installed we fall back to `less -R`.)
  - **a Nerd Font** (icons in neo-tree, lualine, devicons)

### Nerd Font (icons)

If you want icons in the UI (neo-tree/lualine/devicons), install a Nerd Font and set your terminal to use it.

#### WSL2 (recommended)

Install on Windows and set your terminal font:

1. Download a Nerd Font (e.g. JetBrainsMono Nerd Font) from `https://www.nerdfonts.com/font-downloads`
2. Unzip and install the `.ttf` files (right click → Install)
3. In your terminal app (e.g. Windows Terminal): set **Font face** to that Nerd Font
4. Restart the terminal and Neovim

#### Linux-only terminals (optional)

Install into `~/.local/share/fonts`:

```bash
sudo apt update
sudo apt install -y fontconfig unzip
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLo JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o JetBrainsMono.zip
fc-cache -fv
```

#### LazyGit icons (optional)

In `~/.config/lazygit/config.yml` set:

```yaml
gui:
  nerdFontsVersion: "3"
```

### Install this config

Back up your current config and clone this repo into `~/.config/nvim`:

```bash
mv ~/.config/nvim ~/.config/nvim.bak
git clone <your-repo-url> ~/.config/nvim
```

Start Neovim. On first launch, `lazy.nvim` will bootstrap itself and install plugins:

```bash
nvim
```

Useful commands:

- `:Lazy` — open plugin manager UI
- `:Lazy sync` — install/update plugins

## How to use this Neovim config

### Basics

- **Leader**: `<Space>` (set in `lua/vim-options.lua`)
- **Open file explorer**: `<C-n>`
- **Toggle floating terminal**: `<C-\\>`

### Search / navigation (fzf-lua)

- `<leader>ff` — find files
- `<leader>fg` — live grep
- `<leader>fb` — buffers
- `<leader>fh` — help tags
- `<leader>fc` — commands
- `<leader>fk` — keymaps
- `<leader>ft` — fzf-lua builtin picker

### Git workflows

You have **two** ways to open LazyGit:

- `<leader>lg` — LazyGit (via `kdheepak/lazygit.nvim`)
- `<leader>gg` — LazyGit floating terminal (via `toggleterm.nvim`)

Inside LazyGit, a few extra custom commands are configured:

- `<C-p>` — `git push origin <current-branch>`
- `<C-o>` — `git pull origin <current-branch>`
- `<C-b>` — open selected file on GitHub (`gh browse ...`)
- `<C-r>` — create PR (`gh pr create --fill`)

## Packages (plugins)

Plugin list is defined in `lua/plugins.lua` and locked in `lazy-lock.json`.

### Core

- **`folke/lazy.nvim`**: plugin manager
  - **Use**: `:Lazy`

- **`catppuccin/nvim`**: colorscheme
  - **Use**: loaded on startup (`vim.cmd.colorscheme("catppuccin")`)

- **`nvim-tree/nvim-web-devicons`**: filetype icons
  - **Use**: used by UI plugins (neo-tree, lualine, etc.)

### Editing experience

- **`saghen/blink.cmp`**: completion engine
  - **Use**: starts automatically; completion popup while typing
  - **Notes**: snippets powered by `LuaSnip`

- **`L3MON4D3/LuaSnip`**: snippet engine (dependency of blink)

- **`numToStr/Comment.nvim`**: comment toggling
  - **Use**: `gc` motions (default mappings from plugin)

- **`windwp/nvim-autopairs`**: auto-close brackets/quotes
  - **Use**: enabled automatically in insert mode

- **`kylechui/nvim-surround`**: surround text objects
  - **Use**: `ys`, `ds`, `cs` (default mappings from plugin)

### UI / productivity

- **`folke/snacks.nvim`**: dashboard + notifications + utilities
  - **Use**:
    - `<leader>un` — dismiss notifications
    - `<leader>bd` — delete buffer
    - `<leader>cR` — rename current file
    - `<leader>gB` — git browse
    - `<leader>gL` — git blame line
    - `<leader>ss` — scratch buffer

- **`nvim-lualine/lualine.nvim`**: statusline
  - **Use**: auto; configured in `lua/plugins/lualine.lua`

- **`nvim-neo-tree/neo-tree.nvim`**: file explorer
  - **Use**: `<C-n>` opens filesystem tree

- **`akinsho/toggleterm.nvim`**: floating terminal
  - **Use**:
    - `<C-\\>` toggle terminal
    - `<leader>gg` toggle LazyGit terminal

### Git integration

- **`kdheepak/lazygit.nvim`**: LazyGit inside a floating window
  - **Use**:
    - `<leader>lg` open LazyGit
    - `<leader>lc` open/edit LazyGit config
    - `<leader>lf` LazyGit for current file
    - `<leader>ls` file history for current file
    - `<leader>gd` LazyGit current file
    - `<leader>gb` LazyGit blame for current file

- **`lewis6991/gitsigns.nvim`**: git signs in the gutter
  - **Use**: loads on buffer read; shows +/- markers automatically

### LSP / tooling

- **`mason-org/mason.nvim`**: install LSP/DAP/formatters
  - **Use**: `:Mason`

- **`mason-org/mason-lspconfig.nvim`** + **`neovim/nvim-lspconfig`**
  - **Use**: LSP integration base (this config currently sets up Mason + lspconfig deps)

### Syntax

- **`nvim-treesitter/nvim-treesitter`**: syntax highlighting/indent via Tree-sitter
  - **Use**: installs parsers listed in `lua/plugins/treesitter.lua`

## File structure (Lua config)

```text
~/.config/nvim/
  init.lua
  lua/
    vim-options.lua
    plugins.lua
    plugins/
      *.lua
  lazy-lock.json
```

### How it loads

- `init.lua` bootstraps `lazy.nvim`, sets runtimepath, then:
  - loads `lua/vim-options.lua`
  - loads plugin specs via `require("lazy").setup("plugins")` which imports `lua/plugins.lua`

### How to add/edit plugins

1. Create a new file in `lua/plugins/<name>.lua` returning a lazy.nvim plugin spec.
2. Add `require("plugins.<name>")` to `lua/plugins.lua`.
3. Run `:Lazy sync`.
