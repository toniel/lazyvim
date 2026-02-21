-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--- ~/.config/nvim/lua/config/keymaps.lua

-- Window management keymaps
local map = vim.keymap.set

-- Window navigation
map("n", "<leader>wh", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<leader>wj", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<leader>wk", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<leader>wl", "<C-w>l", { desc = "Go to Right Window" })
map("n", "<leader>ww", "<C-w>w", { desc = "Switch Windows" })

-- Window splitting
map("n", "<leader>ws", "<C-w>s", { desc = "Split Window Below" })
map("n", "<leader>wv", "<C-w>v", { desc = "Split Window Right" })
map("n", "<leader>wo", "<C-w>o", { desc = "Only This Window" })

-- Window closing
map("n", "<leader>wc", "<C-w>c", { desc = "Close Window" })
map("n", "<leader>wq", "<C-w>q", { desc = "Quit Window" })

-- Window resizing
map("n", "<leader>w=", "<C-w>=", { desc = "Equally High and Wide" })
map("n", "<leader>w-", "<C-w>-", { desc = "Decrease Height" })
map("n", "<leader>w+", "<C-w>+", { desc = "Increase Height" })
map("n", "<leader>w<", "<C-w><", { desc = "Decrease Width" })
map("n", "<leader>w>", "<C-w>>", { desc = "Increase Width" })
map("n", "<leader>w|", "<C-w>|", { desc = "Max Width" })
map("n", "<leader>w_", "<C-w>_", { desc = "Max Height" })

-- Window movement
map("n", "<leader>wH", "<C-w>H", { desc = "Move Window to the Far Left" })
map("n", "<leader>wJ", "<C-w>J", { desc = "Move Window to the Very Bottom" })
map("n", "<leader>wK", "<C-w>K", { desc = "Move Window to the Very Top" })
map("n", "<leader>wL", "<C-w>L", { desc = "Move Window to the Far Right" })
map("n", "<leader>wr", "<C-w>r", { desc = "Rotate Windows Downwards/Rightwards" })
map("n", "<leader>wR", "<C-w>R", { desc = "Rotate Windows Upwards/Leftwards" })

-- Buffer navigation (often confused with window navigation)
map("n", "<leader>bn", ":bnext<CR>", { desc = "Next Buffer" })
map("n", "<leader>bp", ":bprev<CR>", { desc = "Previous Buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete Buffer" })

-- Tab management (if you use tabs)
map("n", "<leader>tn", ":tabnew<CR>", { desc = "New Tab" })
map("n", "<leader>tc", ":tabclose<CR>", { desc = "Close Tab" })
map("n", "<leader>to", ":tabonly<CR>", { desc = "Only This Tab" })
map("n", "<leader>th", ":tabprev<CR>", { desc = "Previous Tab" })
map("n", "<leader>tl", ":tabnext<CR>", { desc = "Next Tab" })
-- Add any additional keymaps here
