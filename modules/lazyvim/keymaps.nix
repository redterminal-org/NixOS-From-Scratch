{ ... }:

{
  programs.lazyvim.config.keymaps = ''
    -- Buffer navigation
    vim.keymap.set("n", "<C-p>", "<cmd>bprevious<CR>", {
      desc = "Previous buffer",
    })
    vim.keymap.set("n", "<C-n>", "<cmd>bnext<CR>", {
      desc = "Next buffer",
    })
    vim.keymap.set("n", "<M-Left>", "<cmd>bprevious<CR>", {
      desc = "Previous buffer",
    })
    vim.keymap.set("n", "<M-Right>", "<cmd>bnext<CR>", {
      desc = "Next buffer",
    })

    -- Telescope shortcuts
    vim.keymap.set("n", "<Leader>tg", "<cmd>Telescope live_grep<CR>")
    vim.keymap.set("n", "<Leader>tb", "<cmd>Telescope buffers<CR>")
    vim.keymap.set("n", "<Leader>th", "<cmd>Telescope help_tags<CR>")
    vim.keymap.set("n", "<Leader>tf", "<cmd>Telescope find_files<CR>")

    -- Move between windows
    vim.keymap.set("n", "<C-Up>", "<C-W><Up>", { remap = true })
    vim.keymap.set("n", "<C-Down>", "<C-W><Down>", { remap = true })
    vim.keymap.set("n", "<C-Left>", "<C-W><Left>", { remap = true })
    vim.keymap.set("n", "<C-Right>", "<C-W><Right>", { remap = true })
  '';
}
