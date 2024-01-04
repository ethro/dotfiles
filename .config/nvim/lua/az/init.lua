vim.g["python3_host_prog"] = os.getenv("HOME") .. "/.local/venv/nvim/bin/python"

require("az.config.options")
require("az.config.lazy")
require("az.config.keymaps")
