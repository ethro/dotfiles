-- ██████╗ ███████╗███╗   ███╗ █████╗ ██████╗ 
-- ██╔══██╗██╔════╝████╗ ████║██╔══██╗██╔══██╗
-- ██████╔╝█████╗  ██╔████╔██║███████║██████╔╝
-- ██╔══██╗██╔══╝  ██║╚██╔╝██║██╔══██║██╔═══╝ 
-- ██║  ██║███████╗██║ ╚═╝ ██║██║  ██║██║     
-- ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- For normal and visual modes set action to nop and be silent
vim.keymap.set({ 'n', 'v' }, ',', '<Nop>', { silent = true })

-- Personal convenience mappings
vim.keymap.set('n', '<leader>qa', ":qa!<CR>")                             -- Force quit all windows
vim.keymap.set('n', '<leader>q', ":qa<CR>")                               -- Force quit all windows
vim.keymap.set('n', '<leader>b', ":bd<CR>")                               -- delete current buffer
vim.keymap.set('n', '<leader>wa', ":wa<CR>")                              -- write all buffers
vim.keymap.set('n', '<leader>w', ":Trim<CR>")                             -- Run trim according to configuration
vim.keymap.set('n', '<leader>ev', ":tabedit ~/.config/nvim/init.lua<CR>") -- write all buffers
vim.keymap.set('n', '<leader>et', ":tabedit ~/.tmux.conf<CR>")            -- write all buffers

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Telescope Remaps ]]
-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>dm', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Visual mode mapping to move selected lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor where it was when appending next line to current
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in the center of the buffer when paging up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep cursor in the centor of the buffer when searching up and down
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]]) -- :J: ?

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]]) -- begin yank and allow direction action to be added to copy to clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]])          -- just yank current link to clipboard

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]]) -- :J: ?

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>") -- Emacish way of getting out of insert mode

vim.keymap.set("n", "Q", "<nop>")     -- Make 'Q' do nothing
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>") -- :J: ?
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Quickfix lists next and previous
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Convenience search and replace current word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>"); -- :J: Has issues on windows

vim.keymap.set("n", "<leader><leader>", function() vim.cmd("so") end)

vim.keymap.set("n", "<C-q>", function() vim.cmd("!black %") end)
-- nnoremap <buffer><silent> <c-q> <cmd>call Black()<cr>
-- inoremap <buffer><silent> <c-q> <cmd>call Black()<cr>

-- Keep as an example
-- vim.keymap.set("n", "<leader>vwm", function()
--   require("vim-with-me").StartVimWithMe()
-- end)
-- vim.keymap.set("n", "<leader>svwm", function()
--   require("vim-with-me").StopVimWithMe()
-- end)

