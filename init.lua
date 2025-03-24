-- 🔧 LEADER-TASTE setzen
vim.g.mapleader = " "

-- ====================================================
-- 🧠 Global Keybindings
-- ====================================================
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Grep text" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find buffer" })
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Find help" })
vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>", { desc = "Markdown Preview" })
vim.keymap.set("n", "<leader>ms", ":MarkdownPreviewStop<CR>", { desc = "Stop Preview" })

-- ====================================================
-- 🚀 Lazy.nvim Bootstrap
-- ====================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim",
    "--branch=stable",
    lazypath,
  })
  end
  vim.opt.rtp:prepend(lazypath)

  -- ====================================================
  -- 📦 Plugin Setup via Lazy.nvim
  -- ====================================================
  require("lazy").setup({

    -- === Dashboard
    {
      "goolord/alpha-nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "╭────────────────────────────╮",
        "│  Neovim Dev Terminal 🚀    │",
        "│  Hello XSaitoKungX         │",
        "│  Ready to create magic ✨  │",
        "╰────────────────────────────╯",
      }

      dashboard.section.buttons.val = {
        dashboard.button("e", "📄  Neues File", ":ene <BAR> startinsert<CR>"),
                        dashboard.button("f", "🔍  Datei finden", ":Telescope find_files<CR>"),
                        dashboard.button("r", "📁  Letzte Dateien", ":Telescope oldfiles<CR>"),
                        dashboard.button("c", "⚙️  Config öffnen", ":e $MYVIMRC<CR>"),
                        dashboard.button("l", "💤  Plugins verwalten", ":Lazy<CR>"),
                        dashboard.button("q", "❌  Beenden", ":qa<CR>"),
      }

      dashboard.opts.opts.noautocmd = true
      vim.cmd([[autocmd User AlphaReady echo '🧠 Ready to go, Mark!']])
      alpha.setup(dashboard.opts)
      end,
    },

    -- === UI & Theme
    {
      "Mofiqul/dracula.nvim",
      lazy = false,
      priority = 1000,
      config = function()
      vim.cmd("colorscheme dracula")
      end,
    },

    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
      require("lualine").setup({
        options = { theme = "dracula" },
      })
      end,
    },

    -- === Navigation & Datei
    {
      "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
      require("nvim-tree").setup()
      end,
    },

    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.5",
      dependencies = { "nvim-lua/plenary.nvim" },
    },

    {
      "nvim-telescope/telescope-file-browser.nvim",
      dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
      },
      config = function()
      require("telescope").load_extension("file_browser")
      end,
      keys = {
        { "<leader>fe", ":Telescope file_browser<CR>", desc = "File Explorer" },
      },
    },

    -- === LSP, Completion, Snippets
    {
      "VonHeikemen/lsp-zero.nvim",
      branch = "v3.x",
      dependencies = {
        { "neovim/nvim-lspconfig" },
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "L3MON4D3/LuaSnip" },
      },
      config = function()
      local lsp = require("lsp-zero")
      lsp.preset("recommended")

      lsp.on_attach(function(_, bufnr)
      local opts = { buffer = bufnr, remap = false }
      local map = vim.keymap.set
      map("n", "gd", vim.lsp.buf.definition, opts)
      map("n", "K", vim.lsp.buf.hover, opts)
      map("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
      map("n", "<leader>vd", vim.diagnostic.open_float, opts)
      map("n", "[d", vim.diagnostic.goto_next, opts)
      map("n", "]d", vim.diagnostic.goto_prev, opts)
      map("n", "<leader>vca", vim.lsp.buf.code_action, opts)
      map("n", "<leader>vrr", vim.lsp.buf.references, opts)
      map("n", "<leader>vrn", vim.lsp.buf.rename, opts)
      map("i", "<C-h>", vim.lsp.buf.signature_help, opts)
      end)

      lsp.setup()
      end,
    },

    {
      "hrsh7th/nvim-cmp",
      dependencies = { "L3MON4D3/LuaSnip" },
      config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
          luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
              else
                fallback()
                end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                  elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                    else
                      fallback()
                      end
                      end, { "i", "s" }),

                      ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
        },
      })
      end,
    },

    {
      "rafamadriz/friendly-snippets",
      dependencies = { "L3MON4D3/LuaSnip" },
      config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },

    -- === Format
    {
      "stevearc/conform.nvim",
      config = function()
      require("conform").setup({
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          python = { "black" },
        },
      })
      end,
    },

    -- === Enhancements
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
    },

    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
      require("nvim-autopairs").setup({})
      end,
    },

    {
      "numToStr/Comment.nvim",
      config = function()
      require("Comment").setup()
      end,
    },

    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      end,
      config = function()
      require("which-key").setup()
      end,
    },

    -- === Git & Markdown
    {
      "kdheepak/lazygit.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      keys = {
        { "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
      },
    },

    {
      "iamcco/markdown-preview.nvim",
      ft = { "markdown" },
      build = "cd app && npm install",
      config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_browser = ""
      vim.g.mkdp_theme = "dark"
      end,
    },

    -- === Harpoon
    {
      "ThePrimeagen/harpoon",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "Harpoon: Add File" })
      vim.keymap.set("n", "<leader>hm", ui.toggle_quick_menu, { desc = "Harpoon: Menu" })
      vim.keymap.set("n", "<leader>h1", function() ui.nav_file(1) end, { desc = "Harpoon: File 1" })
      vim.keymap.set("n", "<leader>h2", function() ui.nav_file(2) end, { desc = "Harpoon: File 2" })
      vim.keymap.set("n", "<leader>h3", function() ui.nav_file(3) end, { desc = "Harpoon: File 3" })
      vim.keymap.set("n", "<leader>h4", function() ui.nav_file(4) end, { desc = "Harpoon: File 4" })
      end,
    },

  })
