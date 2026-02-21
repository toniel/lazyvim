return {
  "stevearc/conform.nvim",
  keys = {
    -- Custom format keybinding
    {
      "<leader>fm",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
    -- Quick format dengan =
    {
      "=",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "v",
      desc = "Format selection",
    },
  },
  opts = {
    formatters_by_ft = {
      -- PHP
      php = { "php_cs_fixer" },
      blade = { "blade-formatter" },
      -- JavaScript/TypeScript
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      -- Web
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      -- Laravel Blade
      -- Markdown
      markdown = { "prettier" },
      -- Lua
      lua = { "stylua" },
      -- Go
      go = { "goimports", "gofumpt" },
      -- Shell
      sh = { "shfmt" },
      bash = { "shfmt" },
    },
    -- Format on save
  },
}
