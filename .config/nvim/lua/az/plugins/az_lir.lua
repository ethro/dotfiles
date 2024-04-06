local M = {
  {
    "tamago324/lir.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local actions = require("lir.actions")
      local mark_actions = require("lir.mark.actions")
      local clipboard_actions = require("lir.clipboard.actions")

      -- disabling netrw
      -- vim.g.loaded_netrw = 1
      -- vim.g.loaded_netrwPlugin = 1

      require("lir").setup({
        show_hidden_files = true,
        ignore = {},
        devicons = {
          enable = true,
          highlight_dirname = true,
        },
        mappings = {
          ["l"] = actions.edit,
          ["<Enter>"] = actions.edit,
          ["<C-x>"] = actions.split,
          ["<C-v>"] = actions.vsplit,
          ["<C-t>"] = actions.tabedit,

          ["h"] = actions.up,
          ["q"] = actions.quit,

          ["M"] = actions.mkdir,
          ["F"] = actions.newfile,
          ["R"] = actions.rename,
          ["@"] = actions.cd,
          ["Y"] = actions.yank_path,
          ["."] = actions.toggle_show_hidden,
          ["D"] = actions.delete,

          ["J"] = function()
            mark_actions.toggle_mark("n")
            vim.cmd("normal! j")
          end,
          ["C"] = clipboard_actions.copy,
          ["X"] = clipboard_actions.cut,
          ["P"] = clipboard_actions.paste,
        },
        float = {
          winblend = 0,
          curdir_window = {
            enable = true,
            highlight_dirname = true,
          },
        },
        on_init = function() end,
        hide_cursor = false,
      })

      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "lir" },
        callback = function()
          -- use visual mode
          vim.api.nvim_buf_set_keymap(
            0,
            "x",
            "J",
            ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
            { noremap = true, silent = true }
          )

          -- echo cwd
          -- vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
        end,
      })

      local map = vim.keymap.set
      map("n", "<leader>pf", ":lua require('lir.float').toggle()<CR>", { desc = "lir floating window" })
      map("n", "<leader>pv", ":vsplit %<CR><cmd>execute 'e ' .. expand('%:p:h')<CR>", { desc = "lir vsplit" })
      map("n", "<leader>ps", ":split %<CR><cmd>execute 'e ' .. expand('%:p:h')<CR>", { desc = "lir split" })
      map("n", "<leader>pt", ":tabe %<CR><cmd>execute 'e ' .. expand('%:p:h')<CR>", { desc = "lir tabe" })
      map("n", "<leader>l", "<cmd>execute 'e ' .. expand('%:p:h')<CR>", { desc = "lir cwd buffer" })
    end,
  },
}

return M
