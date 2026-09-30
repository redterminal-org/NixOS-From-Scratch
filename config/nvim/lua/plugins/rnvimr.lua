return {
  {
    "kevinhwang91/rnvimr",
    keys = {
      {
        "<leader>r",
        "<cmd>RnvimrToggle<CR>",
        desc = "Ranger",
      },
    },
    init = function()
      vim.g.rnvimr_enable_picker = 1
    end,
  },
}
