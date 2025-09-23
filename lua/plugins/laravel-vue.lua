-- ~/.config/nvim/lua/plugins/laravel-vue.lua
return {
  -- TypeScript and Vue Language Server
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Vue Language Server (Volar)
        volar = {
          init_options = {
            vue = {
              hybridMode = false,
            },
            typescript = {
              tsdk = "./node_modules/typescript/lib",
            },
          },
          settings = {
            vue = {
              server = {
                maxFileSize = 20971520, -- 20MB
              },
            },
          },
        },

        -- TypeScript Language Server
        tsserver = {
          init_options = {
            plugins = {
              {
                name = "@vue/typescript-plugin",
                location = "./node_modules/@vue/typescript-plugin",
                languages = { "javascript", "typescript", "vue" },
              },
            },
            preferences = {
              includePackageJsonAutoImports = "on",
              includeCompletionsForModuleExports = true,
              includeCompletionsForImportStatements = true,
              includeAutomaticOptionalChainCompletions = true,
            },
          },
          settings = {
            typescript = {
              preferences = {
                includePackageJsonAutoImports = "on",
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
                includeAutomaticOptionalChainCompletions = true,
              },
              suggest = {
                autoImports = true,
                completeFunctionCalls = true,
                includeCompletionsForImportStatements = true,
              },
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              preferences = {
                includePackageJsonAutoImports = "on",
                includeCompletionsForImportStatements = true,
              },
              suggest = {
                autoImports = true,
                completeFunctionCalls = true,
                includeCompletionsForImportStatements = true,
              },
            },
          },
        },

        -- PHP/Laravel Language Server
        intelephense = {
          settings = {
            intelephense = {
              files = {
                maxSize = 1000000,
              },
              format = {
                braces = "k&r",
              },
            },
          },
        },

        -- JSON Language Server for package.json, etc.
        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },
      },
    },
  },

  -- Enhanced completion with auto-import support
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
      sources = {
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
        { name = "nvim_lsp_signature_help", priority = 200 },
      },
      formatting = {
        format = function(entry, vim_item)
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
          })[entry.source.name]
          return vim_item
        end,
      },
    },
  },

  -- Treesitter configuration for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "vue",
          "typescript",
          "javascript",
          "tsx",
          "php",
          "json",
          "css",
          "scss",
          "html",
        })
      end

      -- Vue-specific parser configuration
      opts.highlight = opts.highlight or {}
      opts.highlight.additional_vim_regex_highlighting = { "vue" }
    end,
  },

  -- Telescope configuration for better file finding
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          "vendor",
          ".git",
          "storage/framework",
          "bootstrap/cache",
        },
      },
      pickers = {
        find_files = {
          hidden = false,
          -- Include Vue files in pages and components
          find_command = {
            "rg",
            "--files",
            "--hidden",
            "--glob",
            "!**/.git/*",
            "--glob",
            "!**/node_modules/*",
            "--glob",
            "!**/vendor/*",
          },
        },
      },
    },
  },

  -- File icons for Vue and TypeScript files
  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      override = {
        vue = {
          icon = "󰡄",
          color = "#4FC08D",
          name = "Vue",
        },
        ts = {
          icon = "󰛦",
          color = "#519ABA",
          name = "TypeScript",
        },
      },
    },
  },

  -- JSON Schema support for better JSON completion
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },

  -- Optional: Better syntax highlighting for Vue files
  {
    "posva/vim-vue",
    ft = "vue",
    config = function()
      -- Configure vim-vue for better TypeScript support
      vim.g.vue_pre_processors = { "typescript", "scss", "sass", "less", "stylus" }
    end,
  },

  -- Optional: Auto-pairs for better typing experience
  {
    "windwp/nvim-autopairs",
    opts = {
      enable_check_bracket_line = false,
      ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
    },
  },
}
