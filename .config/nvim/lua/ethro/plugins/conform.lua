local M = {
  {
    -- https://github.com/stevearc/conform.nvim#installation
    -- Lightweight yet powerful formatter plugin for Neovim
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua", "luaformatter" },
          json = { "prettierd" },
          markdown = { "prettierd" },
          sh = { "shfmt" },
          yaml = { "yamlfmt" },
          c = { "clang-format" },
          cpp = { "clang-format" },
          -- Conform will run multiple formatters sequentially
          python = { "isort", "black" },
        },
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_fallback = true }
        end,
      })
      -- TODO: Need to clean this up to encompass more disabling of auto features
      -- when working on legacy code that team members/project leads don't want changed.
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
      -- local opts = { noremap = true, silent = true }
      -- vim.api.nvim_set_keymap("n", "<Leader>ua", ":FormatDisable<CR>", opts)
      -- vim.api.nvim_set_keymap("n", "<Leader>uA", ":FormatEnable<CR>", opts)
    end,
  },
}

return M
