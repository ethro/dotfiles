local M = {
  "rmagatti/session-lens",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    {
      -- :J: Review
      "rmagatti/auto-session",
      opts = {
        auto_save_enabled = false,
        auto_restore_enabled = false,
        auto_session_enable_last_session = false,
      },
    },
  },
}

return M
