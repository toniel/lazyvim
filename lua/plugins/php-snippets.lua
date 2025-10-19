return {
  -- Alternative: Plugin modern dengan LSP support
  {
    "gbprod/phpactor.nvim",
    ft = "php",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    keys = {
      {
        "<leader>pi",
        "<cmd>lua require('phpactor').import_class()<CR>",
        desc = "Import PHP class",
        ft = "php",
      },
      {
        "<leader>pc",
        "<cmd>lua require('phpactor').context_menu()<CR>",
        desc = "PHP context menu",
        ft = "php",
      },
      {
        "<leader>pN",
        "<cmd>lua require('phpactor').generate_namespace()<CR>",
        desc = "Generate namespace",
        ft = "php",
      },
    },
    config = function()
      require("phpactor").setup({
        install = {
          bin = vim.fn.stdpath("data") .. "/phpactor/phpactor",
        },
        lspconfig = {
          enabled = true,
        },
      })
    end,
  },
}
