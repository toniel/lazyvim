return {
  "snacks.nvim",
  keys = {
    -- Remove default <leader>e and add new ones
    { "<leader>e", false }, -- disable default
    {
      "<leader>ee",
      function()
        require("snacks").explorer()
      end,
      desc = "Explorer Snacks (root dir)",
    },
    {
      "<leader>eE",
      function()
        require("snacks").explorer(vim.uv.cwd())
      end,
      desc = "Explorer Snacks (cwd)",
    },
    {
      "<C-e>",
      function()
        require("snacks").explorer()
      end,
      desc = "Toggle Explorer",
    },
  },
}
