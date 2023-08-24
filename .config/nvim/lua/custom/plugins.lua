local plugins = {

    -- Plugin for notifications
    {'rcarriga/nvim-notify'},
    -- Indent for blanklines
    { "lukas-reineke/indent-blankline.nvim" },
    -- Better comments
    {'JoosepAlviste/nvim-ts-context-commentstring'},
    -- Syntax aware text-objects, select, move, swap, and peek support.
    {'nvim-treesitter/nvim-treesitter-textobjects'},
    -- Neovim plugin to manage global and project-local settings
    {'folke/neoconf.nvim'},
    -- Setup for init.lua and plugin development
    { "folke/neodev.nvim"},


    -- Better UI for plugins
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      opts = {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
            hover = {
              enabled = false,
          }
          },
        },
      },
      dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
        }
    },
    -- A lot of plugins for better experience
    { 'echasnovski/mini.nvim', version = '*' },
    -- A great starter screen
    {
      'goolord/alpha-nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function ()
          require('alpha').setup(require'alpha.themes.startify'.config)
      end
    },
    -- Another great UI for plugins
    {
      'stevearc/dressing.nvim',
      opts = {},
    },
    -- Calculate startup time
    {'dstein64/vim-startuptime'},
    -- Save and revive sessions
    {
      "folke/persistence.nvim",
      event = "BufReadPre", -- this will only start session saving when an actual file was opened
      opts = {
        -- add any custom options here
      }
    },


    { "elkowar/yuck.vim" , lazy = false },  -- load a plugin at startup

    -- Zen mode plugin
    {
      "Pocco81/TrueZen.nvim",
      cmd = { "TZAtaraxis", "TZMinimalist" },
      config = function()
        require "custom.configs.truezen" -- just an example path
      end,
    },

    -- Plugin for helping with keys
    {
      "folke/which-key.nvim",
      enabled = true,
    },

    -- this opts will extend the default opts
    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = {"html", "css", "bash"},
      },
    },

    -- Highlight other uses of the word under the cursor
    {'RRethy/vim-illuminate'},

    -- Highlight todo and other comments
    {
      "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    },

    -- Snippets for lua language
    {'L3MON4D3/LuaSnip',
    dependencies = { "rafamadriz/friendly-snippets" },},

    -- if you load some function or module within your opt, wrap it with a function
    {
     "nvim-telescope/telescope.nvim",
     opts = {
       defaults = {
         mappings = {
           i = {
             ["<esc>"] = function(...)
                 require("telescope.actions").close(...)
              end,
            },
          },
        },
      },
     },

     {"SmiteshP/nvim-navic"},
     {"williamboman/mason-lspconfig.nvim",},

     {
      "folke/noice.nvim",
      dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
      },
      opts = {
        -- add any options here
        -- lsp = {
        --   signature = {
        --     enable = false,
        --   },
        -- },
      },
      event = "VeryLazy",
      config = function()
        require("noice").setup {
          lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
              -- override the default lsp markdown formatter with Noice
              ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
              -- override the lsp markdown formatter with Noice
              ["vim.lsp.util.stylize_markdown"] = true,
              -- override cmp documentation with Noice (needs the other options to work)
              ["cmp.entry.get_documentation"] = true,
            },
            hover = { enabled = false }, -- <-- HERE!
            signature = { enabled = false }, -- <-- HERE!
          },
          -- you can enable a preset for easier configuration
          presets = {
            bottom_search = false, -- use a classic bottom cmdline for search
            command_palette = false, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true, -- add a border to hover docs and signature help
          },
        }
        -- See: https://github.com/folke/noice.nvim/issues/258
        require("noice.lsp").hover()
        -- See: https://github.com/NvChad/NvChad/issues/1656
        -- vim.notify = require("noice").notify
        -- vim.lsp.handlers["textDocument/hover"] = require("noice").hover
        -- vim.lsp.handlers["textDocument/signatureHelp"] = require("noice").signature
      end,
    },

  }

  return plugins
