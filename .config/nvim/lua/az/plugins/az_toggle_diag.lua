local M = {
  {
    --[[
    -- Current solution to support toggling virtual diagnostics.
    -- TODO: See if there is a better solution.
    --]]
    "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
    config = function()
      require("toggle_lsp_diagnostics").init()
    end,
  },
}

return M
