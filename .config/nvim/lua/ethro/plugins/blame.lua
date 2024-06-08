local M = {
  {
    -- https://github.com/FabijanZulj/blame.nvim
    -- git blame with modes:
    -- virtual - draws the blame info on the far right of the buffer
    -- window  - opens a new buffer to the left and shows the blame info
    "FabijanZulj/blame.nvim",
    config = function()
      require("blame").setup()
    end,
  },
}

return M
