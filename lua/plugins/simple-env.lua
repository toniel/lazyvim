-- Simple .env file configuration to remove warnings
-- Additional configuration to ensure .env diagnostics are disabled

return {
  -- Simple autocmd to disable diagnostics for .env files
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Create autocmd to disable diagnostics for .env files
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
        pattern = { "*.env", ".env*" },
        callback = function()
          -- Turn off diagnostics for this buffer
          vim.diagnostic.disable(0)
          
          -- Set some buffer options for better editing
          vim.opt_local.spell = false
          vim.opt_local.wrap = false
          
          -- Optional: Show a message when opening .env files
          -- vim.notify(".env file opened - diagnostics disabled", vim.log.levels.INFO)
        end,
      })
    end,
  },
}