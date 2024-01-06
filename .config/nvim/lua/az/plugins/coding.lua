--[[
-- coding.lua
--
-- This module maintains plugin configurations for general coding quality of life
-- improvements.
--
-- Plugin configurations for specific languages should be setup under plugins.lang.<lang>.lua
--]]
local M = {
  {
    -- A better annotation generator. Supports multiple languages and annotation conventions.
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("neogen").setup({
        enable = true,
      })
      require("neogen").generate()
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", opts)
    end,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
  },
  {
    -- https://github.com/stevearc/conform.nvim#installation
    -- Lightweight yet powerfule formatter plugin for Neovim
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua", "luaformatter" },
          json = { "prettierd" },
          markdown = { "prettierd" },
          sh = { "shfmt" },
          yaml = { "yamlfmt" },
          -- Conform will run multiple formatters sequentially
          python = { "isort", "black" },
        },
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_fallback = true }
        end,
      })

      -- TODO: Need to clean this up to encompass more disabling of auto features
      -- when working on legacy code that team members/project leads don't want changed.
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap("n", "<Leader>ua", ":FormatDisable<CR>", opts)
      vim.api.nvim_set_keymap("n", "<Leader>uA", ":FormatEnable<CR>", opts)
    end,
  },
  -- snippets
  -- {
  --   "L3MON4D3/LuaSnip",
  --   build = (not jit.os:find("Windows"))
  --       and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
  --     or nil,
  --   dependencies = {
  --     "rafamadriz/friendly-snippets",
  --     config = function()
  --       require("luasnip.loaders.from_vscode").lazy_load()
  --     end,
  --   },
  --   opts = {
  --     history = true,
  --     delete_check_events = "TextChanged",
  --   },
  --   -- stylua: ignore
  --   keys = {
  --     {
  --       "<tab>",
  --       function()
  --         return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
  --       end,
  --       expr = true, silent = true, mode = "i",
  --     },
  --     { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
  --     { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
  --   },
  -- },

  -- {
  --   -- source for file system paths
  --   "petertriho/cmp-git",
  --   lazy = true,
  --   opts = {},
  -- },
  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "nvim-lua/plenary.nvim",
      "hrsh7th/cmp-buffer", -- source for text in buffer
      "hrsh7th/cmp-path", -- source for file system paths
      "L3MON4D3/LuaSnip", -- snippet engine
      "saadparwaiz1/cmp_luasnip", -- for autocompletion
      -- "petertriho/cmp-git", --
      -- "rafamadriz/friendly-snippets", -- useful snippets
      -- "onsails/lspkind.nvim", -- vs-code like pictograms
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      return {
        completion = {
          --completeopt = "menu,menuone,noinsert",
          completeopt = "menu,menuone,preview,noselect",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<Tab>"] = nil,
          ["<S-Tab>"] = nil,
          ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "luasnip" },
          -- { name = "cmp_git" }, -- gitcommit
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(_, item)
            local icons = require("az.config").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
      }
    end,
    ---@param opts cmp.ConfigSchema
    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      require("cmp").setup(opts)
    end,
  },

  -- comments
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {
      enable_autocmd = false,
    },
  },
  {
    "numToStr/Comment.nvim",
    opts = {},
  },
}

return M
