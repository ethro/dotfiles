local kmap = vim.keymap.set
local function print_keys()
  local keys = {}
  local n = 0
  tab = require("lazy.core.config")
  for key, _ in pairs(tab) do
    n = n + 1
    keys[n] = key
    print(key)
  end
  -- print(keys)
  -- print("======")
  -- print(tab.notes_path)
  -- print("------")
  return keys
end

local M = {
  kmap("n", "<leader>dz", function()
    print_keys()
  end, { desc = "debug zettlekasten" })
}

return M
