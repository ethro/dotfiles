return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ninja", "python", "rst", "toml" })
      end
    end,
  },
  -- TODO: Investigate if I can move ft formatters to lang files.
  -- {
  --   "stevearc/conform.nvim",
  --   opts = {
  --     formatters_by_ft = {
  --       ["python"] = { "isort", "black" },
  --     },
  --   },
  -- },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       pylsp = {
  --         settings = {
  --           pylsp = {
  --             plugins = {
  --               pyflakes = { enabled = false },
  --             },
  --           },
  --         },
  --       },
  --     },
  --     setup = {},
  --   },
  -- },
  {
    "nvim-neotest/neotest",
    lazy = true,
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          -- runner = "pytest",
          -- python = ".venv/bin/python",
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          table.insert(opts.ensure_installed, "debugpy")
          table.insert(opts.ensure_installed, "mypy")
          table.insert(opts.ensure_installed, "pydocstyle")
        end,
      },
      {
        "mfussenegger/nvim-dap-python",
        -- stylua: ignore
        keys = {
          { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
          { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
        },
        -- TODO: update to provide more options for finding the desired version
        -- of python
        config = function()
          local path = require("mason-registry").get_package("debugpy"):get_install_path()
          require("dap-python").setup(path .. "/venv/bin/python")
        end,
      },
    },
  },
  {
    "linux-cultist/venv-selector.nvim",
    lazy = true,
    cmd = "VenvSelect",
    opts = function(_, opts)
      if require("az.utils").has("nvim-dap-python") then
        opts.dap_enabled = true
      end
      return vim.tbl_deep_extend("force", opts, {
        name = {
          "venv",
          ".venv",
          "env",
          ".env",
        },
      })
    end,
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
  },
}
