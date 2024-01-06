local Util = require("az.utils")
local M = {
  {
    "metalelf0/jellybeans-nvim",
    dependencies = {
      "rktjmp/lush.nvim",
    },
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme jellybeans-nvim]])
    end,
  },
  {
    -- https://github.com/raafatturki/hex.nvim
    -- Open binary files in hex view
    "raafatturki/hex.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    -- Easy configuration for trimming trailing whitespace and lines
    -- https://github.com/cappyzawa/trim.nvim
    "cappyzawa/trim.nvim",
    lazy = true,
    config = function()
      local trim = require("trim")

      trim.setup({
        ft_blocklist = { "markdown" },
        trim_on_write = true,
        trim_trailing = true,
        trim_last_line = true,
        trim_first_line = true,
      })
    end,
  },
  {
    -- https://github.com/mbbill/undotree
    -- The undo history visualizer for VIM
    "mbbill/undotree", -- Keep track of undo actions even after closing buffer
  },
  -- search/replace in multiple files
  {
    "nvim-pack/nvim-spectre",
    event = "VeryLazy",
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },

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
          Util.on_load("telescope.nvim", function()
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
      { "<leader>/", Util.telescope("live_grep"), desc = "Grep (root dir)" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader><space>", Util.telescope("files"), desc = "Find Files (root dir)" },
      -- find
      { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>fc", Util.telescope.config_files(), desc = "Find Config File" },
      { "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
      { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>fR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
      -- search
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
      { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
      { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>sw", Util.telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
      { "<leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
      { "<leader>sw", Util.telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
      { "<leader>sW", Util.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
      { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
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
      local open_selected_with_trouble = function(...)
        return require("trouble.providers.telescope").open_selected_with_trouble(...)
      end
      local find_files_no_ignore = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        Util.telescope("find_files", { no_ignore = true, default_text = line })()
      end
      local find_files_with_hidden = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        Util.telescope("find_files", { hidden = true, default_text = line })()
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
              ["<c-t>"] = open_with_trouble,
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

  -- which-key helps you remember key bindings by showing a popup
  -- with the active keybindings of the command you started typing.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gs"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
        ["<leader>sn"] = { name = "+noice" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },

  -- Automatically highlights other instances of the word under your cursor.
  -- This works with LSP, Treesitter, and regexp matching to find the other
  -- instances.
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    event = "VeryLazy",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- filetype icons
    },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },

  -- Finds and lists all of the TODO, HACK, BUG, etc comment
  -- in your project and loads them into a browsable list.
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    cmd = { "TodoTrouble", "TodoTelescope" },
    -- event = "LazyFile",
    config = true,
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },
  {
    "tamago324/lir.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local actions = require("lir.actions")
      local mark_actions = require("lir.mark.actions")
      local clipboard_actions = require("lir.clipboard.actions")

      -- disabling netrw
      -- vim.g.loaded_netrw = 1
      -- vim.g.loaded_netrwPlugin = 1

      require("lir").setup({
        show_hidden_files = true,
        ignore = {},
        devicons = {
          enable = true,
          highlight_dirname = true,
        },
        mappings = {
          ["l"] = actions.edit,
          ["<Enter>"] = actions.edit,
          ["<C-x>"] = actions.split,
          ["<C-v>"] = actions.vsplit,
          ["<C-t>"] = actions.tabedit,

          ["h"] = actions.up,
          ["q"] = actions.quit,

          ["M"] = actions.mkdir,
          ["F"] = actions.newfile,
          ["R"] = actions.rename,
          ["@"] = actions.cd,
          ["Y"] = actions.yank_path,
          ["."] = actions.toggle_show_hidden,
          ["D"] = actions.delete,

          ["J"] = function()
            mark_actions.toggle_mark("n")
            vim.cmd("normal! j")
          end,
          ["C"] = clipboard_actions.copy,
          ["X"] = clipboard_actions.cut,
          ["P"] = clipboard_actions.paste,
        },
        float = {
          winblend = 0,
          curdir_window = {
            enable = true,
            highlight_dirname = true,
          },
        },
        on_init = function() end,
        hide_cursor = false,
      })

      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "lir" },
        callback = function()
          -- use visual mode
          vim.api.nvim_buf_set_keymap(
            0,
            "x",
            "J",
            ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
            { noremap = true, silent = true }
          )

          -- echo cwd
          vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
        end,
      })

      local map = vim.keymap.set
      map("n", "<leader>pv", ":lua require('lir.float').toggle()<CR>", { desc = "[e]xplorer [t]oggle" })
      map("n", "<leader>l", "<cmd>execute 'e ' .. expand('%:p:h')<CR>", { desc = "[e]xplorer cwd [f]iles" })
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },
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
  {
    -- Treesitter is a new parser generator tool that we can
    -- use in Neovim to power faster and more accurate
    -- syntax highlighting.
    {
      "nvim-treesitter/nvim-treesitter",
      version = false, -- last release is way too old and doesn't work on Windows
      build = ":TSUpdate",
      -- event = { "LazyFile", "VeryLazy" },
      init = function(plugin)
        -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
        -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
        -- no longer trigger the **nvim-treeitter** module to be loaded in time.
        -- Luckily, the only thins that those plugins need are the custom queries, which we make available
        -- during startup.
        require("lazy.core.loader").add_to_rtp(plugin)
        require("nvim-treesitter.query_predicates")
      end,
      dependencies = {
        {
          "nvim-treesitter/nvim-treesitter-textobjects",
          config = function()
            -- When in diff mode, we want to use the default
            -- vim text objects c & C instead of the treesitter ones.
            local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
            local configs = require("nvim-treesitter.configs")
            for name, fn in pairs(move) do
              if name:find("goto") == 1 then
                move[name] = function(q, ...)
                  if vim.wo.diff then
                    local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
                    for key, query in pairs(config or {}) do
                      if q == query and key:find("[%]%[][cC]") then
                        vim.cmd("normal! " .. key)
                        return
                      end
                    end
                  end
                  return fn(q, ...)
                end
              end
            end
          end,
        },
      },
      cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
      keys = {
        { "<c-space>", desc = "Increment selection" },
        { "<bs>", desc = "Decrement selection", mode = "x" },
      },
      ---@type TSConfig
      ---@diagnostic disable-next-line: missing-fields
      opts = {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
          "bash",
          "c",
          "diff",
          "html",
          "javascript",
          "jsdoc",
          "json",
          "jsonc",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
        textobjects = {
          move = {
            enable = true,
            goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
            goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
            goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
          },
        },
      },
      ---@param opts TSConfig
      config = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          ---@type table<string, boolean>
          local added = {}
          opts.ensure_installed = vim.tbl_filter(function(lang)
            if added[lang] then
              return false
            end
            added[lang] = true
            return true
          end, opts.ensure_installed)
        end
        require("nvim-treesitter.configs").setup(opts)
      end,
    },

    -- Show context of the current function
    {
      "nvim-treesitter/nvim-treesitter-context",
      -- event = "LazyFile",
      enabled = true,
      opts = { mode = "cursor", max_lines = 3 },
      keys = {
        {
          "<leader>ut",
          function()
            local tsc = require("treesitter-context")
            tsc.toggle()
            if Util.inject.get_upvalue(tsc.toggle, "enabled") then
              Util.info("Enabled Treesitter Context", { title = "Option" })
            else
              Util.warn("Disabled Treesitter Context", { title = "Option" })
            end
          end,
          desc = "Toggle Treesitter Context",
        },
      },
    },
  },
}

return M
