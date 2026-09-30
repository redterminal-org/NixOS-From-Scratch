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

-- Alt-Links: previous Buffer
vim.keymap.set("n", "<M-Left>", "<cmd>bprevious<CR>", {
  desc = "Previous buffer",
})
-- Alt-Rechts: next Buffer
vim.keymap.set("n", "<M-Right>", "<cmd>bnext<CR>", {
  desc = "Next buffer",
})

---------------------------------
-- Open Yazi
---------------------------------
vim.keymap.set("n", "<leader>r", function()
  local chooser = vim.fn.tempname()
  local cwd = vim.fn.tempname()

  vim.fn.jobstart({
    "yazi",
    "--chooser-file",
    chooser,
    "--cwd-file",
    cwd,
  }, {
    detach = false,
    on_exit = function()
      vim.schedule(function()
        if vim.fn.filereadable(chooser) == 1 then
          for _, file in ipairs(vim.fn.readfile(chooser)) do
            if file ~= "" then
              vim.cmd.edit(vim.fn.fnameescape(file))
            end
          end
        end

        vim.fn.delete(chooser)
        vim.fn.delete(cwd)
      end)
    end,
  })
end, {
  desc = "Yazi",
})
