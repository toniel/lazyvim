-- lua/plugins/php.lua
return {
  -- Configure conform.nvim for PHP formatting with auto-save
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        php = { "php_cs_fixer" }, -- or { "pint" } for Laravel projects
      },
    },
  },

  -- Configure nvim-lint for PHP linting
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        php = { "phpcs" },
      },
    },
  },

  -- Configure none-ls (null-ls) for additional PHP support
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.phpcsfixer)
      table.insert(opts.sources, nls.builtins.diagnostics.phpcs)
    end,
  },

  -- Configure PHP LSP (Intelephense)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          settings = {
            intelephense = {
              format = {
                enable = true,
              },
              environment = {
                includePaths = { "vendor/" },
              },
            },
          },
        },
      },
    },
  },

  -- PHP Debug Adapter
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")
      local path = require("mason-registry").get_package("php-debug-adapter"):get_install_path()
      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { path .. "/extension/out/phpDebug.js" },
      }
    end,
  },
}
