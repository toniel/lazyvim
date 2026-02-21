return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Disable vue_ls, use volar only for Vue
        vue_ls = { enabled = false },
        volar = {
          filetypes = { "vue" },
          init_options = {
            vue = {
              hybridMode = true, -- Use hybrid mode with vtsls
            },
          },
          on_new_config = function(new_config, new_root_dir)
            local tsdk = new_root_dir .. "/node_modules/typescript/lib"
            if vim.fn.isdirectory(tsdk) == 1 then
              new_config.init_options = new_config.init_options or {}
              new_config.init_options.typescript = { tsdk = tsdk }
            end
          end,
        },
        -- vtsls handles TypeScript, including in Vue files via plugin
        vtsls = {
          settings = {
            typescript = {
              suggest = {
                completeFunctionCalls = true,
                includeCompletionsForModuleExports = true,
              },
            },
          },
        },
      },
    },
  },
}
