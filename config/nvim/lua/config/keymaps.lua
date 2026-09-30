---------------------------------
-- Buffer navigation
---------------------------------
-- Ctrl+P: previous Buffer
vim.keymap.set("n", "<C-p>", "<cmd>bprevious<CR>", {
  desc = "Previous buffer",
})
-- Ctrl+N: next Buffer
vim.keymap.set("n", "<C-n>", "<cmd>bnext<CR>", {
  desc = "Next buffer",
})

-- Alt+Links: previous Buffer
vim.keymap.set("n", "<M-Left>", "<cmd>bprevious<CR>", {
  desc = "Previous buffer",
})
-- Alt-Rechts: next Buffer
vim.keymap.set("n", "<M-Right>", "<cmd>bnext<CR>", {
  desc = "Next buffer",
})

---------------------------------
-- Open Ranger
---------------------------------
