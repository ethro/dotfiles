local MUtil = {}

local function item_to_result(item)
  local row = (item.lnum or 1) - 1
  local col = (item.col or 1) - 1

  if not item.bufnr then
    local fname = vim.fn.fnamemodify(item.filename, ":p")
    if vim.fn.filereadable(fname) == 0 and item.cwd then
      fname = vim.fn.fnamemodify(item.cwd .. "/" .. item.filename, ":p")
    end
    item.bufnr = vim.fn.bufnr(fname, true)
  end

  local pitem = {
    row = row,
    col = col,
    message = item.text,
    severity = 0,
    range = {
      start = { line = row, character = col },
      ["end"] = { line = row, character = -1 },
    },
  }

  -- return util.process_item(pitem, item.bufnr)
end

-- Util.init
function MUtil.on_load(name, fn)
  local Config = require("lazy.core.config")
  if Config.plugins[name] and Config.plugins[name]._.loaded then
    fn(name)
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end
--
--Util.root
function MUtil.realpath(path)
  if path == "" or path == nil then
    return nil
  end
  path = vim.loop.fs_realpath(path) or path
  return path
end
function MUtil.bufpath(buf)
  return MUtil.realpath(vim.api.nvim_buf_get_name(assert(buf)))
end
MUtil.detectors = {}
function MUtil.detectors.pattern(buf, patterns)
  patterns = type(patterns) == "string" and { patterns } or patterns
  local path = MUtil.bufpath(buf) or vim.loop.cwd()
  local pattern = vim.fs.find(patterns, { path = path, upward = true })[1]
  return pattern and { vim.fs.dirname(pattern) } or {}
end

function MUtil.resolve(spec)
  if MUtil.detectors[spec] then
    return MUtil.detectors[spec]
  elseif type(spec) == "function" then
    return spec
  end
  return function(buf)
    return MUtil.detectors.pattern(buf, spec)
  end
end
MUtil.spec = { "lsp", { ".git", "lua" }, "cwd" }
function MUtil.detect(opts)
  opts = opts or {}
  opts.spec = opts.spec or type(vim.g.root_spec) == "table" and vim.g.root_spec or MUtil.spec
  opts.buf = (opts.buf == nil or opts.buf == 0) and vim.api.nvim_get_current_buf() or opts.buf

  local ret = {} -- ---@type LazyRoot[]
  for _, spec in ipairs(opts.spec) do
    local paths = MUtil.resolve(spec)(opts.buf)
    paths = paths or {}
    paths = type(paths) == "table" and paths or { paths }
    local roots = {} ---@type string[]
    for _, p in ipairs(paths) do
      local pp = MUtil.realpath(p)
      if pp and not vim.tbl_contains(roots, pp) then
        roots[#roots + 1] = pp
      end
    end
    table.sort(roots, function(a, b)
      return #a > #b
    end)
    if #roots > 0 then
      ret[#ret + 1] = { spec = spec, paths = roots }
      if opts.all == false then
        break
      end
    end
  end
  return ret
end
function MUtil.is_win()
  return vim.loop.os_uname().sysname:find("Windows") ~= nil
end
MUtil.cache = {}
function MUtil.root_get(opts)
  local buf = vim.api.nvim_get_current_buf()
  local ret = MUtil.cache[buf]
  if not ret then
    local roots = MUtil.detect({ all = false })
    ret = roots[1] and roots[1].paths[1] or vim.loop.cwd()
    MUtil.cache[buf] = ret
  end
  if opts and opts.normalize then
    return ret
  end
  return (MUtil.is_win() and ret:gsub("/", "\\")) or ret
end

--
-- Util.telescope
function MUtil.telescope(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts
    opts = vim.tbl_deep_extend("force", { cwd = MUtil.root_get() }, opts or {}) -- --[[@as utils.telescope.opts]]
    if builtin == "files" then
      if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
        opts.show_untracked = true
        builtin = "git_files"
      else
        builtin = "find_files"
      end
    end
    if opts.cwd and opts.cwd ~= vim.loop.cwd() then
      ---@diagnostic disable-next-line: inject-field
      opts.attach_mappings = function(_, map)
        map("i", "<a-c>", function()
          local action_state = require("telescope.actions.state")
          local line = action_state.get_current_line()
          MUtil.telescope(
            params.builtin,
            vim.tbl_deep_extend("force", {}, params.opts or {}, { cwd = false, default_text = line })
          )()
        end)
        return true
      end
    end

    require("telescope.builtin")[builtin](opts)
  end
end

function MUtil.config_files()
  return MUtil.telescope("find_files", { cwd = vim.fn.stdpath("config") })
end
--

local M = {
  -- Fuzzy finder.
  -- The default key bindings to find files will use Telescope's
  -- `find_files` or `git_files` depending on whether the
  -- directory is a git repo.
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
        config = function()
          MUtil.on_load("telescope.nvim", function()
            require("telescope").load_extension("fzf")
          end)
        end,
      },
    },
    keys = {
      {
        "<leader>,",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      {
        "<leader>/",
        MUtil.telescope("live_grep"),
        desc = "Grep (root dir)",
      },
      {
        "<leader>:",
        "<cmd>Telescope command_history<cr>",
        desc = "Command History",
      },
      {
        "<leader><space>",
        MUtil.telescope("files"),
        desc = "Find Files (root dir)",
      },
      -- find
      { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      {
        "<leader>fc",
        MUtil.config_files(),
        desc = "Find Config File",
      },
      {
        "<leader>ff",
        MUtil.telescope("files"),
        desc = "Find Files (root dir)",
      },
      {
        "<leader>fF",
        MUtil.telescope("files", { cwd = false }),
        desc = "Find Files (cwd)",
      },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>fR", MUtil.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
      -- search
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      {
        "<leader>sc",
        "<cmd>Telescope command_history<cr>",
        desc = "Command History",
      },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      {
        "<leader>sd",
        "<cmd>Telescope diagnostics bufnr=0<cr>",
        desc = "Document diagnostics",
      },
      {
        "<leader>sD",
        "<cmd>Telescope diagnostics<cr>",
        desc = "Workspace diagnostics",
      },
      {
        "<leader>sg",
        MUtil.telescope("live_grep"),
        desc = "Grep (root dir)",
      },
      { "<leader>sG", MUtil.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      {
        "<leader>sH",
        "<cmd>Telescope highlights<cr>",
        desc = "Search Highlight Groups",
      },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      {
        "<leader>sw",
        MUtil.telescope("grep_string", { word_match = "-w" }),
        desc = "Word (root dir)",
      },
      { "<leader>sW", MUtil.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
      {
        "<leader>sw",
        MUtil.telescope("grep_string"),
        mode = "v",
        desc = "Selection (root dir)",
      },
      {
        "<leader>sW",
        MUtil.telescope("grep_string", { cwd = false }),
        mode = "v",
        desc = "Selection (cwd)",
      },
      {
        "<leader>uC",
        MUtil.telescope("colorscheme", { enable_preview = true }),
        desc = "Colorscheme with preview",
      },
      {
        "<leader>ss",
        function()
          require("telescope.builtin").lsp_document_symbols({
            symbols = require("az.config").get_kind_filter(),
          })
        end,
        desc = "Goto Symbol",
      },
      {
        "<leader>sS",
        function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols({
            symbols = require("az.config").get_kind_filter(),
          })
        end,
        desc = "Goto Symbol (Workspace)",
      },
    },
    opts = function()
      local actions = require("telescope.actions")

      local open_with_trouble = function(...)
        return require("trouble.providers.telescope").open_with_trouble(...)
      end

      local open_tab = function(prompt_bufnr, _mode)
        local entry = require("telescope.actions.state").get_selected_entry()
        vim.api.nvim_input("<esc>")
        return vim.cmd("tabedit " .. entry.path)
      end

      local open_vsplit = function(prompt_bufnr, _mode)
        local entry = require("telescope.actions.state").get_selected_entry()
        vim.api.nvim_input("<esc>")
        return vim.cmd("vsplit " .. entry.path)
      end

      local open_selected_with_trouble = function(...)
        return require("trouble.providers.telescope").open_selected_with_trouble(...)
      end
      local find_files_no_ignore = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        MUtil.telescope("find_files", { no_ignore = true, default_text = line })()
      end
      local find_files_with_hidden = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        MUtil.telescope("find_files", { hidden = true, default_text = line })()
      end

      local yank_selected_path = function()
        local entry = require("telescope.actions.state").get_selected_entry()
        local cb_opts = vim.opt.clipboard:get()
        if vim.tbl_contains(cb_opts, "unnamed") then
          vim.fn.setreg("*", entry.path)
        end
        if vim.tbl_contains(cb_opts, "unnamedplus") then
          vim.fn.setreg("+", entry.path)
        end
        vim.fn.setreg("", entry.path)
      end

      return {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          -- open files in the first window that is an actual file.
          -- use the current window if no other window is available.
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          mappings = {
            i = {
              -- ["<c-T>"] = open_with_trouble,
              ["<c-t>"] = open_tab,
              ["<c-v>"] = open_vsplit,
              ["<c-y>"] = yank_selected_path,
              ["<a-t>"] = open_selected_with_trouble,
              ["<a-i>"] = find_files_no_ignore,
              ["<a-h>"] = find_files_with_hidden,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,
            },
            n = {
              ["q"] = actions.close,
            },
          },
        },
      }
    end,
  },
}

return M
