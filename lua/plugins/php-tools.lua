-- File: ~/.config/nvim/lua/plugins/php-tools.lua
-- Konfigurasi lengkap untuk PHP auto-generate class dan namespace

return {
  -- 1. LuaSnip untuk snippets (sudah built-in di LazyVim)
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = function(_, opts)
      local ls = require("luasnip")

      -- Function untuk auto-generate namespace dari path file (PSR-4 compliant)
      local function get_namespace()
        local path = vim.fn.expand("%:p:h")
        local project_root = vim.fn.getcwd()

        -- Remove project root dari path
        local relative_path = path:gsub("^" .. vim.pesc(project_root) .. "/", "")

        -- Deteksi namespace root (app, src, atau App)
        local namespace_root = "App"
        local namespace_path = ""

        if relative_path:match("^app/(.*)") then
          namespace_root = "App"
          namespace_path = relative_path:match("^app/(.*)")
        elseif relative_path:match("^src/(.*)") then
          namespace_root = "App"
          namespace_path = relative_path:match("^src/(.*)")
        elseif relative_path:match("^App/(.*)") then
          namespace_root = "App"
          namespace_path = relative_path:match("^App/(.*)")
        elseif relative_path == "app" or relative_path == "src" or relative_path == "App" then
          return namespace_root
        end

        -- Jika ada sub-path, convert ke namespace format
        if namespace_path and namespace_path ~= "" then
          -- Convert path separator ke namespace separator
          namespace_path = namespace_path:gsub("/", "\\")

          -- Capitalize setiap segment untuk PSR-4
          namespace_path = namespace_path:gsub("([^\\]+)", function(segment)
            return segment:sub(1, 1):upper() .. segment:sub(2)
          end)

          return namespace_root .. "\\" .. namespace_path
        end

        return namespace_root
      end

      -- Function untuk auto-generate class name dari filename
      local function get_classname()
        return vim.fn.expand("%:t:r")
      end

      -- Tambahkan PHP snippets
      ls.add_snippets("php", {
        -- Auto-generate class dengan namespace
        ls.snippet("phpclass", {
          ls.text_node("<?php"),
          ls.text_node({ "", "" }),
          ls.text_node("declare(strict_types=1);"),
          ls.text_node({ "", "" }),
          ls.text_node("namespace "),
          ls.function_node(get_namespace, {}),
          ls.text_node(";"),
          ls.text_node({ "", "", "" }),
          ls.text_node("class "),
          ls.function_node(get_classname, {}),
          ls.text_node({ "", "{" }),
          ls.text_node({ "", "    " }),
          ls.insert_node(0),
          ls.text_node({ "", "}" }),
        }),

        -- Auto-generate interface
        ls.snippet("phpinterface", {
          ls.text_node("<?php"),
          ls.text_node({ "", "" }),
          ls.text_node("declare(strict_types=1);"),
          ls.text_node({ "", "" }),
          ls.text_node("namespace "),
          ls.function_node(get_namespace, {}),
          ls.text_node(";"),
          ls.text_node({ "", "", "" }),
          ls.text_node("interface "),
          ls.function_node(get_classname, {}),
          ls.text_node({ "", "{" }),
          ls.text_node({ "", "    " }),
          ls.insert_node(0),
          ls.text_node({ "", "}" }),
        }),

        -- Auto-generate trait
        ls.snippet("phptrait", {
          ls.text_node("<?php"),
          ls.text_node({ "", "" }),
          ls.text_node("declare(strict_types=1);"),
          ls.text_node({ "", "" }),
          ls.text_node("namespace "),
          ls.function_node(get_namespace, {}),
          ls.text_node(";"),
          ls.text_node({ "", "", "" }),
          ls.text_node("trait "),
          ls.function_node(get_classname, {}),
          ls.text_node({ "", "{" }),
          ls.text_node({ "", "    " }),
          ls.insert_node(0),
          ls.text_node({ "", "}" }),
        }),
      })

      return opts
    end,
  },

  -- 2. vim-php-namespace untuk import class
  {
    "arnaud-lb/vim-php-namespace",
    ft = "php",
    keys = {
      { "<leader>pu", "<cmd>call PhpInsertUse()<CR>", desc = "PHP: Insert use statement", mode = "n" },
      { "<leader>pe", "<cmd>call PhpExpandClass()<CR>", desc = "PHP: Expand class", mode = "n" },
      { "<leader>ps", "<cmd>call PhpSortUse()<CR>", desc = "PHP: Sort use statements", mode = "n" },
    },
    init = function()
      -- Auto sort after insert
      vim.g.php_namespace_sort_after_insert = 1
    end,
  },

  -- 3. phpactor.nvim (optional, lebih advanced)
  {
    "gbprod/phpactor.nvim",
    ft = "php",
    cmd = { "PhpactorImportClass", "PhpactorContextMenu", "PhpactorClassNew", "PhpactorImportMissingClasses" },
    build = function()
      require("phpactor.handler.update")()
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    keys = {
      { "<leader>pm", "<cmd>PhpactorContextMenu<CR>", desc = "PHP: Context menu", mode = "n" },
      { "<leader>pn", "<cmd>PhpactorClassNew<CR>", desc = "PHP: New class", mode = "n" },
      { "<leader>pi", "<cmd>PhpactorImportClass<CR>", desc = "PHP: Import class", mode = "n" },
      { "<leader>pa", "<cmd>PhpactorImportMissingClasses<CR>", desc = "PHP: Import all missing", mode = "n" },
    },
    config = function()
      require("phpactor").setup({
        install = {
          bin = vim.fn.stdpath("data") .. "/phpactor/bin/phpactor",
        },
        lspconfig = {
          enabled = false,
          options = {},
        },
      })
    end,
  },
}
