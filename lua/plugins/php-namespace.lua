-- File: ~/.config/nvim/lua/plugins/php-namespace.lua
return {
  -- Plugin untuk auto-generate namespace dan class PHP
  {
    "arnaud-lb/vim-php-namespace",
    ft = "php",
    keys = {
      {
        "<leader>pn",
        "<cmd>call PhpInsertUse()<CR>",
        desc = "Insert PHP use statement",
        ft = "php",
      },
      {
        "<leader>pe",
        "<cmd>call PhpExpandClass()<CR>",
        desc = "Expand PHP class name",
        ft = "php",
      },
      {
        "<leader>ps",
        "<cmd>call PhpSortUse()<CR>",
        desc = "Sort PHP use statements",
        ft = "php",
      },
    },
    config = function()
      -- Set command untuk sort use statements setelah insert
      vim.g.php_namespace_sort_after_insert = 1
    end,
  },
}
