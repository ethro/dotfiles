local M = {
  {
    -- https://github.com/chrisgrieser/nvim-scissors
    -- Automagical editing and creation of snippets.
    "chrisgrieser/nvim-scissors",
  },
  {
    -- https://github.com/FabijanZulj/blame.nvim
    -- git blame with modes:
    -- virtual - draws the blame info on the far right of the buffer
    -- window  - opens a new buffer to the left and shows the blame info
    "FabijanZulj/blame.nvim",
    event = "VeryLazy",
  },
  {
    "FabijanZulj/blame.nvim",
    config = function()
      require("blame").setup()
    end,
  },
}

--[[
--blame.nvim
--Comment.nvim
--goto-preview
--hex.nvim
--kanagawa.nvim
--nvim-scissors
--toggle-lsp-diagnostics
--]]

return {}
