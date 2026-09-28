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
-- Alt+Rechts: next Buffer
vim.keymap.set("n", "<M-Right>", "<cmd>bnext<CR>", {
  desc = "Next buffer",
})

---------------------------------
-- Open Ranger to choose files --
---------------------------------
vim.keymap.set("n", "<leader>r", function()
  local chooser = vim.fn.tempname()
  local cwd = vim.fn.expand("%:p:h")

  if cwd == "" or vim.fn.isdirectory(cwd) == 0 then
    cwd = vim.fn.getcwd()
  end

  -- Open own tab for ranger
  vim.cmd("tabnew")

  local ranger_tab = vim.api.nvim_get_current_tabpage()

  vim.fn.jobstart({
    "ranger",
    "--choosefiles=" .. chooser,
  }, {
    term = true,
    cwd = cwd,

    on_exit = function()
      vim.schedule(function()
        -- read chosen files
        local files = {}

        if vim.fn.filereadable(chooser) == 1 then
          files = vim.fn.readfile(chooser)
        end

        vim.fn.delete(chooser)

        -- Ranger-Tab close
        if vim.api.nvim_tabpage_is_valid(ranger_tab) then
          vim.api.nvim_set_current_tabpage(ranger_tab)
          vim.cmd("tabclose")
        end

        -- Open files in origin tabs
        for _, file in ipairs(files) do
          if file ~= "" and vim.fn.filereadable(file) == 1 then
            vim.cmd("edit " .. vim.fn.fnameescape(file))
          end
        end
      end)
    end,
  })

  vim.cmd("startinsert")
end, {
  desc = "Ranger",
})
