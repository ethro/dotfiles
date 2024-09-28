local M = {
  {
    "ethro/jellybeans-nvim",
    dependencies = {
      "rktjmp/lush.nvim",
    },
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme jellybeans-nvim]])
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 10,
  },
  {
    "bluz71/vim-moonfly-colors",
    priority = 10,
  },
  {
    "EdenEast/nightfox.nvim",
    priority = 10,
    -- config = function()
    --   vim.cmd([[colorscheme carbonfox]])
    -- end,
  },
}

return M
