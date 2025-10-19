return {
  -- Aggressively disable all diagnostics for .env files
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Multiple autocmds to ensure diagnostics are disabled
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "BufEnter", "BufWinEnter" }, {
        pattern = { "*.env", ".env*", ".env" },
        callback = function(event)
          local bufnr = event.buf
          
          -- Disable diagnostics multiple ways
          vim.diagnostic.disable(bufnr)
          vim.diagnostic.reset(nil, bufnr)
          vim.diagnostic.hide(nil, bufnr)
          
          -- Set filetype
          vim.api.nvim_buf_set_option(bufnr, 'filetype', 'sh')
          
          -- Disable LSP for this buffer
          vim.defer_fn(function()
            local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
            for _, client in ipairs(clients) do
              vim.lsp.buf_detach_client(bufnr, client.id)
            end
          end, 100)
        end,
      })
      
      -- Also disable diagnostics globally for .env files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sh", "bash", "dotenv" },
        callback = function(event)
          local filename = vim.api.nvim_buf_get_name(event.buf)
          if filename:match("%.env") or filename:match("/%.env") then
            vim.diagnostic.disable(event.buf)
          end
        end,
      })
      
      return opts
    end,
  },

  -- Add dotenv syntax highlighting
  {
    "chr4/nginx.vim",
    ft = { "nginx", "dotenv" },
  },

  -- Better syntax highlighting for .env files
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "bash" })
      end
      
      -- Configure treesitter for .env files
      opts.highlight = opts.highlight or {}
      opts.highlight.additional_vim_regex_highlighting = opts.highlight.additional_vim_regex_highlighting or {}
      vim.list_extend(opts.highlight.additional_vim_regex_highlighting, { "dotenv" })
      
      return opts
    end,
  },

  -- Optional: Add a plugin specifically for .env file support
  {
    "tpope/vim-dotenv",
    ft = "dotenv",
    config = function()
      -- Set up proper filetype detection for .env files
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { ".env", ".env.*" },
        callback = function()
          vim.bo.filetype = "dotenv"
          -- Disable some features that cause noise in .env files
          vim.bo.spell = false
          vim.wo.number = true
          vim.wo.relativenumber = false
        end,
      })
    end,
  },
}