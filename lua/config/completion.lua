-- ~/.config/nvim/lua/plugins/completion.lua
return {
  {
    "hrsh7th/nvim-cmp",
    opts = {
      sources = {
        { name = "nvim_lsp", priority = 1000 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
      },
    },
  },
}
