-- Buffer navigation
-- Ctrl+P: previous Buffer
vim.keymap.set("n", "<C-p>", "<cmd>bprevious<CR>", {
  desc = "Previous buffer",
})
-- Ctrl+N: next Buffer
vim.keymap.set("n", "<C-n>", "<cmd>bnext<CR>", {
  desc = "Next buffer",
})

-- Alt-Links: previous Buffer
vim.keymap.set("n", "<M-Left>", "<cmd>bprevious<CR>", {
  desc = "Previous buffer",
})
-- Alt-Rechts: next Buffer
vim.keymap.set("n", "<M-Right>", "<cmd>bnext<CR>", {
  desc = "Next buffer",
})

-- Telescope Shortcuts
vim.api.nvim_set_keymap("n", "<Leader>tg", [[<cmd>Telescope live_grep<CR>]], { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>tb", [[<cmd>Telescope buffers<CR>]], { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>th", [[<cmd>Telescope help_tags<CR>]], { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>tf", [[<cmd>Telescope find_files<CR>]], { noremap = true })

-- Map Control + Arrow keys to move between windows
vim.api.nvim_set_keymap("n", "<C-Up>", [[<C-W><Up>]], {})
vim.api.nvim_set_keymap("n", "<C-Down>", [[<C-W><Down>]], {})
vim.api.nvim_set_keymap("n", "<C-Left>", [[<C-W><Left>]], {})
vim.api.nvim_set_keymap("n", "<C-Right>", [[<C-W><Right>]], {})
