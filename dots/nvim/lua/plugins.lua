-- vim:foldmethod=marker

local pdf_viewer = "sioyek"
---@type NvPluginSpec[]
return {
  -- IDE {{{
  {
    "hrsh7th/nvim-cmp",
    config = function(_, opts)
      -- opts.sources[#opts.sources + 1] = { name = 'cmdline' }
      -- opts.sources[#opts.sources + 1] = { name = 'conjure' }
      local cmp = require "cmp"
      cmp.setup(opts)
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
    dependencies = {
      "hrsh7th/cmp-cmdline",
      -- { 'PaterJason/cmp-conjure',
      --   dependencies = 'Olical/conjure',
      -- },
    },
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
  },

  {
    "whoissethdaniel/mason-tool-installer.nvim",
    lazy = false,
    config = function()
      require("mason-tool-installer").setup {
        -- a list of all tools you want to ensure are installed upon
        -- start
        ensure_installed = {
          -- lua stuff
          "lua-language-server",
          "stylua",
          -- c/cpp stuff
          "clangd",
          "clang-format",
          -- clojure stuff,
          -- 'clj-kondo',
          -- 'clojure-lsp',
          -- zig
          "zls",
          -- go
          "gopls",
          -- typst
          "typst-lsp",
          -- python
          "pyright",
        },

        auto_update = false,
        run_on_start = true,
        start_delay = 3000,
        debounce_hours = 5,
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "c",
        "go",
        "lua",
        "dart",
        "cuda",
        -- 'clojure',
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeFocus", "NvimTreeClose" },
  },
  {
    "kelly-lin/ranger.nvim",
    lazy = false,
    config = function()
      local ranger_nvim = require "ranger-nvim"
      ranger_nvim.setup {
        enable_cmds = false,
        replace_netrw = true,
        keybinds = {
          ["ov"] = ranger_nvim.OPEN_MODE.vsplit,
          ["oh"] = ranger_nvim.OPEN_MODE.split,
          ["ot"] = ranger_nvim.OPEN_MODE.tabedit,
          ["or"] = ranger_nvim.OPEN_MODE.rifle,
        },
        ui = {
          border = "none",
          height = 1,
          width = 1,
          x = 0.5,
          y = 0.5,
        },
      }
      vim.api.nvim_set_keymap("n", "<leader>ef", "", {
        noremap = true,
        callback = function()
          require("ranger-nvim").open(true)
        end,
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      require "configs.dap"
    end,
  },

  {
    "stevearc/overseer.nvim",
    config = function()
      require("overseer").setup {
        templates = { "builtin" },
      }
    end,
  },

  {
    "ahmedkhalf/project.nvim",
    -- BUG: project.nvim doesn't run well if we lazy load it
    enabled = false,
    config = function()
      require("project_nvim").setup {
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "project.clj", "build.zig" },
      }
    end,
  },
  -- }}}
  -- UI {{{
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<localleader>", '"', "'", "`", "c", "v", ";" },
    config = function()
      require("which-key").setup {
        triggers_blacklist = {
          t = { "<leader>" },
        },
      }
      require "configs.whichkey"
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    opts = {
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        OK = { icon = "󰩐 ", color = "info" },
        HACK = { icon = "󰠥 ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX", "ERROR" } },
        PERF = { icon = "󱎫 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = "󰹕 ", color = "hint", alt = { "INFO" } },
      },
    },
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "TroubleToggle",
  },
  {
    "stevearc/dressing.nvim",
    opts = {},
    lazy = false,
  },
  {
    "toppair/reach.nvim",
    dependencies = "nvim-web-devicons",
    config = function()
      require("reach").setup {
        notifications = true,
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require "configs.telescope"
    end,
  },
  -- }}}
  -- Editing {{{
  {
    event = "InsertEnter",
    "keaising/im-select.nvim",
    config = function()
      require("im_select").setup {}
    end,
  },
  {
    "machakann/vim-sandwich",
    keys = {
      { "sa", mode = { "n", "v" } },
      { "sd", mode = { "n", "v" } },
      { "sr", mode = { "n", "v" } },
    },
  },
  {
    "wellle/targets.vim",
    keys = {
      { "a", mode = { "x", "o" } },
      { "i", mode = { "x", "o" } },
    },
  },
  {
    "ggandor/leap.nvim",
    keys = {
      { "f", "<Plug>(leap)", noremap = true, mode = { "n", "v", "o" } },
    },
  },
  { "tpope/vim-sleuth", lazy = false },
  { "tpope/vim-repeat", keys = "." },

  -- }}}
  -- Typesetting {{{
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      require("which-key").register({
        ["p"] = { "<cmd>MarkdownPreviewToggle<CR>", "Toggle markdown preview" },
      }, { prefix = "<localleader>" })
      vim.g.mkdp_browser = "mercury-browser"
      vim.g.mkdp_theme = "dark"
    end,
    ft = "markdown",
  },
  {
    "lervag/vimtex",
    ft = "tex",
    config = function()
      vim.g.vimtex_view_method = pdf_viewer
    end,
  },
  {
    "kaarmu/typst.vim",
    ft = "typst",
    config = function()
      vim.g.typst_pdf_viewer = pdf_viewer
    end,
  },
  -- }}}
  -- Languages {{{
  -- Oil {{{
  {
    "glyh/vim-oil",
    ft = "ysh",
  },
  -- }}}
  -- Clojure {{{
  {
    "eraserhd/parinfer-rust",
    enabled = false,
    ft = "clojure",
    build = "cargo build --release",
  },
  {
    "Olical/conjure",
    enabled = false,
    ft = "clojure",
    config = function()
      require "configs.conjure"
    end,
  },
  {
    "guns/vim-sexp",
    enabled = false,
    ft = "clojure",
    dependencies = "tpope/vim-sexp-mappings-for-regular-people",
  },
  -- }}}
  -- Flutter {{{
  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("flutter-tools").setup {}
    end,
  },
  -- }}}
  -- }}}
}
