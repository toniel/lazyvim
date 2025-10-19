-- ~/.config/nvim/lua/plugins/copilot.lua

return {
  -- GitHub Copilot official plugin
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- Disable default tab mapping (optional, if you want to use custom keymaps)
      vim.g.copilot_no_tab_map = true

      -- Custom accept mapping (Alt+l or Ctrl+j)
      vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })

      -- Additional keymaps
      vim.keymap.set("i", "<C-H>", "<Plug>(copilot-dismiss)")
      vim.keymap.set("i", "<C-L>", "<Plug>(copilot-next)")
      vim.keymap.set("i", "<C-K>", "<Plug>(copilot-previous)")

      -- Copilot filetypes (optional)
      vim.g.copilot_filetypes = {
        ["*"] = true,
        ["markdown"] = true,
        ["yaml"] = true,
      }
    end,
  },

  -- Copilot Chat integration (optional but recommended)
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = false,
      window = {
        layout = "float",
        relative = "editor",
        width = 0.8,
        height = 0.8,
      },
    },
    keys = {
      { "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Copilot Chat Toggle" },
      { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "Copilot Chat Explain" },
      { "<leader>ct", "<cmd>CopilotChatTests<cr>", desc = "Copilot Chat Tests" },
      { "<leader>cf", "<cmd>CopilotChatFix<cr>", desc = "Copilot Chat Fix" },
    },
  },
}
