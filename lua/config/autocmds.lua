-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
--- Konfigurasi untuk Vue dan TypeScript path mapping
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- Auto commands for Laravel/Vue projects

-- Set project root detection
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  group = vim.api.nvim_create_augroup("LaravelProject", { clear = true }),
  pattern = "*",
  callback = function()
    local buf_name = vim.api.nvim_buf_get_name(0)
    if buf_name:match("resources/js/") then
      -- Find Laravel project root
      local current_dir = vim.fn.expand("%:p:h")
      local project_root = vim.fn.finddir(".git", current_dir .. ";")

      if project_root == "" then
        project_root = vim.fn.findfile("composer.json", current_dir .. ";")
        if project_root ~= "" then
          project_root = vim.fn.fnamemodify(project_root, ":h")
        end
      else
        project_root = vim.fn.fnamemodify(project_root, ":h")
      end

      if project_root ~= "" and project_root ~= vim.fn.getcwd() then
        vim.cmd("cd " .. project_root)
        print("Changed directory to: " .. project_root)
      end
    end
  end,
})

-- Vue file specific settings
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("VueFiles", { clear = true }),
  pattern = "*.vue",
  callback = function()
    vim.opt_local.filetype = "vue"
    -- Set path untuk gf command
    vim.opt_local.path:prepend(vim.fn.getcwd() .. "/resources/js")
    vim.opt_local.suffixesadd:prepend(".vue")
    vim.opt_local.suffixesadd:prepend(".ts")
    vim.opt_local.suffixesadd:prepend(".js")
  end,
})

-- TypeScript/JavaScript files in Laravel project
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("LaravelJS", { clear = true }),
  pattern = { "*/resources/js/**/*.ts", "*/resources/js/**/*.js", "*/resources/js/**/*.vue" },
  callback = function()
    -- Ensure working directory is project root
    local project_root = vim.fn.findfile("composer.json", vim.fn.expand("%:p:h") .. ";")
    if project_root ~= "" then
      project_root = vim.fn.fnamemodify(project_root, ":h")
      if vim.fn.getcwd() ~= project_root then
        vim.api.nvim_set_current_dir(project_root)
      end
    end
  end,
})
-- Auto-format PHP files on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.php",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
