local M = {
  {
    "jemag/telescope-diff.nvim",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
    },
    keys = {
      {
        "<leader>cc",
        function()
          require("telescope").extensions.diff.diff_current({ hidden = true })
        end,
        desc = "Compare file with current",
      },
      {
        "<leader>cC",
        function()
          require("telescope").extensions.diff.diff_files({ hidden = true })
        end,
        desc = "Compare file with current",
      },
    },
    config = function()
      require("telescope").load_extension("diff")
    end,
  },
}

return M
