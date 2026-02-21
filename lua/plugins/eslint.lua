return {
  "nvim-lspconfig",
  opts = {
    servers = {
      eslint = {
        settings = {
          format = true,
        },
      },
    },
  },
  keys = {
    { "<leader>ef", "<cmd>EslintFixAll<cr>", desc = "ESLint Fix All" },
  },
}
