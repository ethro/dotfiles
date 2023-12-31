-- Keymaps are automatically loaded on the VeryLazy event
-- Add any additional keymaps here
local kmap = vim.keymap.set

local nvim_init = "~/.config/nvim/lua/az/config/lazy.lua"
local tmux_conf = "~/.tmux.conf"

kmap("n", "<leader>ev", ":tabedit" .. nvim_init .. "<CR>", { desc = "Open nvim init.lua" })
kmap("n", "<leader>et", ":tabedit" .. tmux_conf .. "<CR>", { desc = "Open tmux.conf" })

-- Get LSP configuration information and open it in a buffer
kmap(
  "n",
  "<leader>cL",
  ':enew|put=execute(\\"lua print(vim.inspect(vim.lsp.get_active_clients()))\\")<CR>',
  { desc = "Lsp config to buffer" }
)

local tld = require("toggle_lsp_diagnostics")

-- stylua: ignore start
kmap("n", "<leader>uu", function() tld.toggle_underline() end, { desc = "Toggle LSP diag Underline" })
-- kmap("n", "<leader>tls", function() tld.toggle_signs() end, { desc = "Toggle LSP diag Signs" })
kmap("n", "<leader>uv", function() tld.toggle_virtual_text() end, { desc = "Toggle LSP diag Virtual text" })
-- kmap("n", "<leader>tlp", function() tld.toggle_update_in_insert() end, { desc = "Toggle LSP" })
-- kmap("n", "<leader>tld", function() tld.toggle_diagnostic() end, { desc = "Toggle LSP" })
-- kmap("n", "<leader>tldd", function() tld.turn_on_diagnostics_default() end, { desc = "Toggle LSP" })
-- kmap("n", "<leader>tldo", function() tld.turn_off_diagnostics() end, { desc = "Toggle LSP" })
-- kmap("n", "<leader>tldf", function() tld.turn_on_diagnostics() end, { desc = "Toggle LSP" })
-- stylua: ignore end

kmap("n", "<leader>bd", ":bd<CR>", { desc = "Buffer delete" })

-- :J: From LazyVim
local Util = require("az.utils")
-- better up/down
kmap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
kmap({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
kmap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
kmap({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
kmap("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
kmap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
kmap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
kmap("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
kmap("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
kmap("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
kmap("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
kmap("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
kmap("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
kmap("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
kmap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
kmap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
kmap("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
kmap("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
kmap("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
kmap("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
kmap("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
kmap("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
kmap("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
kmap("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
kmap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
kmap(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
kmap("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
kmap("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
kmap("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
kmap("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
kmap("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
kmap("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
kmap("i", ",", ",<c-g>u")
kmap("i", ".", ".<c-g>u")
kmap("i", ";", ";<c-g>u")

-- save file
kmap({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

--keywordprg
kmap("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
kmap("v", "<", "<gv")
kmap("v", ">", ">gv")

-- lazy
kmap("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
kmap("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

kmap("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
kmap("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

kmap("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
kmap("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- formatting
kmap({ "n", "v" }, "<leader>cf", function()
  Util.format({ force = true })
end, { desc = "Format" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
kmap("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
kmap("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
kmap("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
kmap("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
kmap("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
kmap("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
kmap("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- stylua: ignore start

-- toggle options
kmap("n", "<leader>uf", function() Util.format.toggle() end, { desc = "Toggle auto format (global)" })
kmap("n", "<leader>uF", function() Util.format.toggle(true) end, { desc = "Toggle auto format (buffer)" })
kmap("n", "<leader>us", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
kmap("n", "<leader>uw", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
kmap("n", "<leader>uL", function() Util.toggle("relativenumber") end, { desc = "Toggle Relative Line Numbers" })
kmap("n", "<leader>ul", function() Util.toggle.number() end, { desc = "Toggle Line Numbers" })
kmap("n", "<leader>ud", function() Util.toggle.diagnostics() end, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
kmap("n", "<leader>uc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })
if vim.lsp.inlay_hint then
  kmap("n", "<leader>uh", function() vim.lsp.inlay_hint(0, nil) end, { desc = "Toggle Inlay Hints" })
end
kmap("n", "<leader>uT", function() if vim.b.ts_highlight then vim.treesitter.stop() else vim.treesitter.start() end end, { desc = "Toggle Treesitter Highlight" })

-- lazygit
kmap("n", "<leader>gg", function() Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false }) end, { desc = "Lazygit (root dir)" })
kmap("n", "<leader>gG", function() Util.terminal({ "lazygit" }, {esc_esc = false, ctrl_hjkl = false}) end, { desc = "Lazygit (cwd)" })

-- quit
kmap("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- highlights under cursor
kmap("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- floating terminal
local lazyterm = function() Util.terminal(nil, { cwd = Util.root() }) end
kmap("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })
kmap("n", "<leader>fT", function() Util.terminal() end, { desc = "Terminal (cwd)" })
kmap("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
kmap("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })

-- Terminal Mappings
kmap("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
kmap("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
kmap("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
kmap("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
kmap("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
kmap("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
kmap("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- windows
kmap("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
kmap("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
kmap("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
kmap("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
kmap("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
kmap("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

-- tabs
kmap("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
kmap("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
kmap("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
kmap("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
kmap("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
kmap("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
