local kmap = vim.keymap.set

local function az_dbg()
  print("az_dbg")
end

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
    az_dbg()
  end, { desc = "az debug" }),
}

return M
