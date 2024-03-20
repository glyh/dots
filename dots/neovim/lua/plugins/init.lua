-- vim:foldmethod=marker

---@type NvPluginSpec[]
return {
  -- IDE {{{
  { 'hrsh7th/nvim-cmp',
    config = function(_, opts)
      opts.sources[#opts.sources + 1] = { name = 'cmdline' }
      local cmp = require('cmp')
      cmp.setup(opts)
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end,
    dependencies = 'hrsh7th/cmp-cmdline'
  },
  { 'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
    },
    opts = {
      extensions_list = { 'themes', 'terms', 'ui-select', 'projects' },
    }
  },
  { 'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require('telescope').load_extension('ui-select')
    end
  },
  {
    'stevearc/conform.nvim',
    -- event = 'BufWritePre' -- uncomment for format on save
    config = function()
      require 'configs.conform'
    end,
  },

  {
    'neovim/nvim-lspconfig',
    config = function()
      require('nvchad.configs.lspconfig').defaults()
      require 'configs.lspconfig'
    end,
  },

  {
    'nvimtools/none-ls.nvim',
    config = function()
      require 'custom.configs.null-ls'
    end,
  },

  {
  	'williamboman/mason.nvim',
  	opts = {
  		ensure_installed = {
        -- lua stuff
        'lua-language-server',
        'stylua',
        -- c/cpp stuff
        'clangd',
        'clang-format',
        -- clojure stuff,
        'clj-kondo',
        'clojure-lsp',
        -- zig
        'zls',
        -- go 
        'gopls',
  		},
  	},
  },

  {
  	'nvim-treesitter/nvim-treesitter',
  	opts = {
  		ensure_installed = {
  			'c', 'go', 'lua',
  		},
  	},
  },

  { 'nvim-tree/nvim-tree.lua',
    cmd = {'NvimTreeFocus', 'NvimTreeClose'},
  },

  { 'folke/which-key.nvim',
    keys = { '<leader>', '"', "'", '`', 'c', 'v', ';' },
    config = function()
      require('which-key').setup({
        triggers_blacklist = {
          t = { '<leader>' },
        }
      })
      require 'configs.whichkey'
    end,
  },
  { 'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = false,
    opts = {
      keywords = {
        FIX = {
          icon = ' ', -- icon used for the sign, and in search results
          color = 'error', -- can be a hex color, or a named color (see below)
          alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = ' ', color = 'info' },
        OK = { icon = '󰩐 ', color = 'info' },
        HACK = { icon = '󰠥 ', color = 'warning' },
        WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX', 'ERROR' } },
        PERF = { icon = '󱎫 ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
        NOTE = { icon = '󰹕 ', color = 'hint', alt = { 'INFO' } },
      },
    }
  },
  { 'mfussenegger/nvim-dap',
    config = function() require 'custom.configs.dap' end,
  },

  { 'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'TroubleToggle',
  },

  { 'stevearc/overseer.nvim',
    config = function()
      require('overseer').setup({
        templates = { 'builtin' },
      })
    end
  },

  { 'toppair/reach.nvim',
    dependencies = 'nvim-web-devicons',
    config = function()
      require('reach').setup({
        notifications = true
      })
    end
  },
  { 'ahmedkhalf/project.nvim',
    -- BUG: project.nvim doesn't run well if we lazy load it
    lazy = false,
    config = function()
      require('project_nvim').setup{
        patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', 'project.clj', 'build.zig' },
      }
    end
  },
  -- }}}
  -- Editing {{{
  { 'machakann/vim-sandwich',
    keys = {
      { 'sa', mode = { 'n', 'v' } },
      { 'sd', mode = { 'n', 'v' } },
      { 'sr', mode = { 'n', 'v' } },
    }
  },
  { 'wellle/targets.vim',
    keys = {
      { 'a', mode = { 'x', 'o' } },
      { 'i', mode = { 'x', 'o' } },
    },
  },
  { 'ggandor/leap.nvim',
    keys = {
      { 'f', '<Plug>(leap)', noremap = true, mode = {'n', 'v', 'o'} },
    },
  },
  { 'tpope/vim-sleuth', lazy = false },
  { 'tpope/vim-repeat', keys = '.' },

  -- }}}
  -- Markdown {{{
  {'iamcco/markdown-preview.nvim',
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    config = function()
      require('which-key').register({
        ['p'] = { '<cmd>MarkdownPreviewToggle<CR>', 'Toggle markdown preview'}
      }, { prefix = '<localleader>' })
      vim.g.mkdp_browser = 'firefox'
      vim.g.mkdp_theme = 'dark'
    end,
    ft = 'markdown'
  },
  -- }}}
  -- Latex {{{
  { 'lervag/vimtex',
    ft='tex',
    config = function()
      vim.g.vimtex_view_method = 'zathura'
    end
  },
  -- }}}
}
