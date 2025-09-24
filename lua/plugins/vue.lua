return {
  -- LSP Configuration dengan path mapping yang benar
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        volar = {
          init_options = {
            typescript = {
              tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
            },
          },
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern("composer.json", "package.json", ".git")(fname)
          end,
        },
        tsserver = {
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern("composer.json", "package.json", "tsconfig.json", ".git")(fname)
          end,
          init_options = {
            preferences = {
              includePackageJsonAutoImports = "auto",
            },
          },
        },
      },
    },
  },

  -- Autocomplete dengan path yang benar
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-path",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources or {}, {
        {
          name = "path",
          option = {
            trailing_slash = true,
            label_trailing_slash = true,
          },
        },
      }))
      return opts
    end,
  },

  -- Working directory setup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      -- Set working directory ke Laravel project root
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.filereadable("composer.json") == 1 or vim.fn.filereadable("artisan") == 1 then
            local project_root = vim.fn.getcwd()
            vim.api.nvim_set_current_dir(project_root)
          end
        end,
      })
    end,
  },
}
