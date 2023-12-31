local Config = require("az.config")
-- local Float = require("lazy.view.float")
local LazyConfig = require("lazy.core.config")
local Plugin = require("lazy.core.plugin")
local Text = require("lazy.view.text")
local Util = require("az.utils")

---@class LazyExtraSource
---@field name string
---@field desc? string
---@field module string

---@class LazyExtra
---@field name string
---@field source LazyExtraSource
---@field module string
---@field desc? string
---@field enabled boolean
---@field managed boolean
---@field row? number
---@field plugins string[]
---@field optional string[]

---@class util.extras
local M = {}

---@type LazyExtraSource[]
M.sources = {
  { name = "User", desc = "User extras", module = "plugins.extras" },
}

---@type string[]
M.state = nil

---@return LazyExtra[]
function M.get()
  M.state = M.state or LazyConfig.spec.modules
  local extras = {} ---@type LazyExtra[]
  for _, source in ipairs(M.sources) do
    local root = Util.find_root(source.module)
    if root then
      Util.walk(root, function(path, name, type)
        if type == "file" and name:match("%.lua$") then
          name = path:sub(#root + 2, -5):gsub("/", ".")
          local ok, extra = pcall(M.get_extra, source, source.module .. "." .. name)
          if ok then
            extras[#extras + 1] = extra
          end
        end
      end)
    end
  end
  table.sort(extras, function(a, b)
    return a.name < b.name
  end)
  return extras
end

---@param modname string
---@param source LazyExtraSource
function M.get_extra(source, modname)
  local enabled = vim.tbl_contains(M.state, modname)
  local spec = Plugin.Spec.new({ import = modname }, { optional = true })
  local plugins = {} ---@type string[]
  local optional = {} ---@type string[]
  for _, p in pairs(spec.plugins) do
    if p.optional then
      optional[#optional + 1] = p.name
    else
      plugins[#plugins + 1] = p.name
    end
  end
  table.sort(plugins)
  table.sort(optional)

  ---@type LazyExtra
  return {
    source = source,
    name = modname:sub(#source.module + 2),
    module = modname,
    enabled = enabled,
    desc = require(modname).desc,
    managed = vim.tbl_contains(Config.json.data.extras, modname) or not enabled,
    plugins = plugins,
    optional = optional,
  }
end

function M.show()
end

return M
