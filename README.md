```markdown
# 🧠 XSaitoKungX's Neovim Setup

Welcome to my personal Neovim configuration — optimized for productivity, fullstack development and pure style 😎

## 🚀 Features

- 🔧 **Lazy.nvim** as plugin manager
- 🎨 **Dracula Theme** for dark hacker vibes
- 📁 **NvimTree** for file navigation
- 🔍 **Telescope** + file browser
- 🧠 **LSP-Zero** with autocompletion & diagnostics
- ✂️ **LuaSnip** + friendly-snippets + smart Tab navigation
- 💬 **Comment.nvim** for fast commenting
- 💾 **Autoformat on save** with conform.nvim
- 🔖 **Harpoon** to jump between files like a boss
- 🧪 **Treesitter** for better syntax highlighting
- 🖥️ **Alpha.nvim** dashboard with custom ASCII welcome
- 📄 **Markdown Preview** with browser support
- 🐙 **LazyGit** in Neovim!

## 🗂️ Structure

```bash
~/.config/nvim/
├── init.lua            # Main config
├── lua/                # (optional) custom Lua modules
└── README.md           # This file!
```

## 🧠 Keybindings (LEADER = Space)

| Key           | Action                        |
|---------------|-------------------------------|
| `<leader>e`   | Toggle File Explorer (NvimTree) |
| `<leader>ff`  | Find files (Telescope)        |
| `<leader>fg`  | Live grep                     |
| `<leader>fb`  | Buffers                       |
| `<leader>fh`  | Help tags                     |
| `<leader>ha`  | Harpoon: add file             |
| `<leader>hm`  | Harpoon: menu                 |
| `<leader>gg`  | Open LazyGit                  |
| `<leader>mp`  | Markdown preview              |

## 📦 Plugins Managed by [lazy.nvim](https://github.com/folke/lazy.nvim)

## ✨ Screenshot

*(optional – kannst du ein Bild einfügen, z. B. von deinem Dashboard)*

---

## 🛠️ Setup

```bash
git clone https://github.com/XSaitoKungX/nvim-setups.git ~/.config/nvim
nvim
```
> Lazy.nvim lädt automatisch alle Plugins beim ersten Start 🚀
