-- Immediate fix for .env diagnostics - run this in Neovim with :lua dofile(vim.fn.stdpath('config')..'/lua/fix-env.lua')

-- Get current buffer
local bufnr = vim.api.nvim_get_current_buf()
local filename = vim.api.nvim_buf_get_name(bufnr)

-- Check if this is a .env file
if filename:match("%.env") then
  print("Fixing .env diagnostics for buffer " .. bufnr)
  
  -- Disable diagnostics
  vim.diagnostic.disable(bufnr)
  vim.diagnostic.reset(nil, bufnr)
  vim.diagnostic.hide(nil, bufnr)
  
  -- Clear any existing diagnostics
  vim.diagnostic.set(vim.lsp.util.make_floating_preview_contents, bufnr, {})
  
  -- Detach LSP clients
  local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
  for _, client in ipairs(clients) do
    print("Detaching LSP client: " .. client.name)
    vim.lsp.buf_detach_client(bufnr, client.id)
  end
  
  print("Diagnostics disabled for .env file!")
else
  print("This is not a .env file: " .. filename)
end