return {
  -- Mason
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "intelephense",
        "php-cs-fixer",
        "phpstan",
      },
    },
  },

  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          settings = {
            intelephense = {
              format = {
                enable = false, -- Disable formatting dari intelephense
              },
              files = {
                maxSize = 5000000,
              },
            },
          },
        },
      },
    },
    -- Disable LSP format on save
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "intelephense" then
            client.server_capabilities.documentFormattingProvider = false
          end
        end,
      })
    end,
  },

  -- Conform for formatting
}
