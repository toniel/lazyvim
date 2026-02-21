return {
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    -- Ensure pickers table exists
    opts.pickers = opts.pickers or {}
    
    -- Configure find_files to show hidden files but respect gitignore
    opts.pickers.find_files = {
      hidden = true,
      no_ignore = false,
      follow = true,
      find_command = {
        "rg",
        "--files",
        "--hidden",
        "--glob", "!**/.git/*",
        "--glob", "!**/node_modules/*",
        "--glob", "!**/vendor/*",
        "--glob", "!**/storage/framework/*",
        "--glob", "!**/bootstrap/cache/*",
      },
    }
    
    -- Also configure live_grep to search in hidden files
    opts.pickers.live_grep = {
      additional_args = function()
        return { "--hidden", "--glob", "!**/.git/*" }
      end,
    }
    
    -- Configure default file ignore patterns
    opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
      file_ignore_patterns = {
        "%.git/",
        "node_modules/",
        "vendor/",
        "storage/framework/",
        "bootstrap/cache/",
      },
    })
    
    return opts
  end,
  keys = {
    -- Override the default find files keymap to ensure it uses our config
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files({
          hidden = true,
          no_ignore = false,
          find_command = {
            "rg",
            "--files",
            "--hidden",
            "--glob", "!**/.git/*",
            "--glob", "!**/node_modules/*",
            "--glob", "!**/vendor/*",
          },
        })
      end,
      desc = "Find Files (including hidden)",
    },
    -- Add a specific keymap for finding ALL files including ignored ones
    {
      "<leader>fF",
      function()
        require("telescope.builtin").find_files({
          hidden = true,
          no_ignore = true,
          find_command = {
            "rg",
            "--files",
            "--hidden",
            "--no-ignore",
            "--glob", "!**/.git/*",
            "--glob", "!**/node_modules/*",
            "--glob", "!**/vendor/*",
          },
        })
      end,
      desc = "Find All Files (including hidden and ignored)",
    },
    -- Laravel-specific keymap to find .env files
    {
      "<leader>fe",
      function()
        require("telescope.builtin").find_files({
          hidden = true,
          no_ignore = true,
          search_dirs = { "." },
          find_command = {
            "find", ".", "-maxdepth", "1", "-name", ".env*", "-type", "f"
          },
        })
      end,
      desc = "Find .env files",
    },
  },
}