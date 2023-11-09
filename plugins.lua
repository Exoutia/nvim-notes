local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }

  -- hlargs is a plugin to highlight arguments in function calls
  {
    "m-demare/hlargs.nvim",
    event = "BufWinEnter",
    config = function()
      require("hlargs").setup()
    end,
  },

  -- dashboard is a plugin to show a dashboard when opening nvim
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    config = function()
      require("dashboard").setup {
        -- stylua: ignore start
        -- config
        config = {
          header = {
            '',
          '███████╗██╗  ██╗ ██████╗ ██╗   ██╗████████╗██╗ █████╗ ',
          '██╔════╝╚██╗██╔╝██╔═══██╗██║   ██║╚══██╔══╝██║██╔══██╗',
          '█████╗   ╚███╔╝ ██║   ██║██║   ██║   ██║   ██║███████║',
          '██╔══╝   ██╔██╗ ██║   ██║██║   ██║   ██║   ██║██╔══██║',
          '███████╗██╔╝ ██╗╚██████╔╝╚██████╔╝   ██║   ██║██║  ██║',
          '╚══════╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝    ╚═╝   ╚═╝╚═╝  ╚═╝',
            '                                                   notes',
            '',
         },
        },
        theme = "hyper",
      }
      -- stylua: ignore end
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },

  -- for searhing and jumping between keywords
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = function()
      require("flash").setup {}
    end,
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-z>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },

  -- for moving lines updown below and etc
  {
    "echasnovski/mini.move",
    version = false,
    event = "BufWinEnter",
    config = function()
      require("mini.move").setup {
        -- add any configuration options here
      }
    end,
  },
  {
    "echasnovski/mini.ai",
    version = false,
    event = "BufWinEnter",
    config = function()
      require("mini.ai").setup {
        -- add any configuration options here
      }
    end,
  },
  {
    "echasnovski/mini.surround",
    version = false,
    event = "BufWinEnter",
    config = function()
      require("mini.surround").setup {
        -- add any configuration options here
      }
    end,
  },

  -- neogit
  {
    "neogitorg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
    },
    config = function()
      require("neogit").setup {
        kind = "split", -- opens neogit in a split
        signs = {
          -- { CLOSED, OPENED }
          section = { "", "" },
          item = { "", "" },
          hunk = { "", "" },
        },
        integrations = { diffview = true }, -- adds integration with diffview.nvim
      }
    end,
  },

  -- Workspaces
  {
    "natecraddock/workspaces.nvim",
    cmd = { "WorkspacesList", "WorkspacesAdd", "WorkspacesOpen", "WorkspacesRemove" },
    config = function()
      require("workspaces").setup {
        hooks = {
          open = "Telescope find_files",
        },
      }
    end,
  },
}

return plugins
