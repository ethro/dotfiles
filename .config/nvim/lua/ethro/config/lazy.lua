local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local secs_in_week = 604800

require("lazy").setup({
  spec = {
    { import = "ethro.plugins" },
  },
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = {
    enabled = true,
    frequency = secs_in_week, -- check weekly
    notify = false, -- get a notification when new updates are found
  },
  change_detection = {
    notify = false,
  },
})
