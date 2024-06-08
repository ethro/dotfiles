local M = {
  "stevearc/oil.nvim",
  -- opts = {
  --  default_file_explorer = true,
  -- },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
    })
    local kmap = vim.keymap.set
    -- kmap("n", "<leader>pf", ":lua require('lir.float').toggle()<CR>", { desc = "oil floating window" })
    kmap("n", "<leader>ov", ":vsplit %<CR><cmd>execute 'e ' .. expand('%:p:h')<CR>", { desc = "oil vsplit" })
    kmap("n", "<leader>os", ":split %<CR><cmd>execute 'e ' .. expand('%:p:h')<CR>", { desc = "oil split" })
    kmap("n", "<leader>ot", ":tabe %<CR><cmd>execute 'e ' .. expand('%:p:h')<CR>", { desc = "oil tabe" })
    kmap("n", "<leader>oo", ":Oil<CR>", { desc = "Open Oil" })
  end,
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

return M
