-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- -- Keymaps untuk meniru shortcuts VSCode

local map = vim.keymap.set

-- Format document (Ctrl+Shift+I in VSCode)
map("n", "<leader>fi", function()
  vim.lsp.buf.format({ timeout_ms = 2000 })
end, { desc = "Format Document" })

-- Organize imports (Ctrl+Shift+O in VSCode)
map("n", "<leader>oi", function()
  vim.lsp.buf.code_action({
    context = { only = { "source.organizeImports" } },
    apply = true,
  })
end, { desc = "Organize Imports" })

-- ESLint fix all
map("n", "<leader>ef", function()
  vim.lsp.buf.code_action({
    context = { only = { "source.fixAll.eslint" } },
    apply = true,
  })
end, { desc = "ESLint Fix All" })

-- Quick save (Ctrl+S equivalent)
map("n", "<C-s>", ":w<CR>", { desc = "Save File" })
map("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save File" })

-- Format selection (equivalent to Format Selection in VSCode)
map("v", "<leader>f", function()
  vim.lsp.buf.format({
    range = {
      start = vim.api.nvim_buf_get_mark(0, "<"),
      ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
    },
  })
end, { desc = "Format Selection" })

-- Code actions (Ctrl+. in VSCode)
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
map("v", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })

-- Toggle inlay hints
map("n", "<leader>ih", function()
  if vim.lsp.inlay_hint then
    vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled(0))
  end
end, { desc = "Toggle Inlay Hints" })

-- Vue specific keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = "vue",
  callback = function()
    -- Go to definition in split
    map("n", "<leader>gd", function()
      vim.cmd("split")
      vim.lsp.buf.definition()
    end, { buffer = true, desc = "Go to Definition (Split)" })

    -- Find references
    map("n", "<leader>gr", vim.lsp.buf.references, { buffer = true, desc = "Find References" })

    -- Rename symbol
    map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = true, desc = "Rename Symbol" })
  end,
})

-- Error navigation (F8/Shift+F8 in VSCode)
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })

-- Show hover documentation (equivalent to hovering in VSCode)
map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })

-- Show signature help
map("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
-- Disable the winbar/breadcrumbs completely
vim.opt.winbar = ""
vim.g.autoformat = true
