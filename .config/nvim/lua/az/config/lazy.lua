local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local secs_in_week = 604800

require("lazy").setup({
  spec = {
    { import = "az.plugins" },
    -- { import = "az.plugins.extras.lang" },
    -- { import = "az.plugins.extras.editor" },
    -- { import = "az.plugins.extras.test.core" },
    -- { import = "az.plugins.dap.core" },
  },
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = {
    enabled = true,
    frequency = secs_in_week, -- check weekly
  },
  change_detection = {
    notify = false,
  },
})
