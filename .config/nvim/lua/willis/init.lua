-- ██╗    ██╗██╗██╗     ██╗     ██╗███████╗
-- ██║    ██║██║██║     ██║     ██║██╔════╝
-- ██║ █╗ ██║██║██║     ██║     ██║███████╗
-- ██║███╗██║██║██║     ██║     ██║╚════██║
-- ╚███╔███╔╝██║███████╗███████╗██║███████║
--  ╚══╝╚══╝ ╚═╝╚══════╝╚══════╝╚═╝╚══════╝

vim.g['python3_host_prog'] = os.getenv("HOME") .. "/.local/venv/nvim/bin/python"

require("willis.set")
require("willis.lazy")
require("willis.plugin_setup")
require("willis.remap")
