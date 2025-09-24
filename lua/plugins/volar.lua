return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        volar = {
          filetypes = { "vue" },
          init_options = {
            vue = {
              hybridMode = false,
            },
            typescript = {
              tsdk = "node_modules/typescript/lib",
            },
          },
          on_new_config = function(new_config, new_root_dir)
            -- Pastikan tsconfig.json path benar
            local tsconfig_path = new_root_dir .. "/tsconfig.json"
            if vim.fn.filereadable(tsconfig_path) == 1 then
              new_config.init_options = new_config.init_options or {}
              new_config.init_options.typescript = new_config.init_options.typescript or {}
              new_config.init_options.typescript.tsdk = new_root_dir .. "/node_modules/typescript/lib"
            end
          end,
          settings = {
            vue = {
              complete = {
                casing = {
                  tags = "kebab",
                  props = "camel",
                },
              },
            },
            typescript = {
              preferences = {
                includePackageJsonAutoImports = "auto",
              },
              suggest = {
                paths = true,
                autoImports = true,
              },
            },
          },
        },
        tsserver = {
          filetypes = { "typescript", "javascript" },
          init_options = {
            preferences = {
              includePackageJsonAutoImports = "auto",
            },
          },
        },
      },
    },
  },

  -- Tambahan untuk auto-import
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = opts.sources or {}

      -- Pastikan nvim-lsp source ada dan prioritas tinggi
      local sources = {
        { name = "nvim_lsp", priority = 1000 },
        { name = "path", priority = 250 },
      }

      -- Merge dengan sources yang sudah ada
      for _, source in ipairs(opts.sources) do
        if source.name ~= "nvim_lsp" and source.name ~= "path" then
          table.insert(sources, source)
        end
      end

      opts.sources = sources

      return opts
    end,
  },
}
