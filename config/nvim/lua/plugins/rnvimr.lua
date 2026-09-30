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

      vim.g.rnvimr_layout = {
        relative = "editor",
        width = vim.o.columns - 2,
        height = vim.o.lines - 2,
        col = 1,
        row = 1,
        style = "minimal",
      }

      vim.g.rnvimr_action = {
        ["<CR>"] = 'eval fm.client.rpc_edit([f for f in fm.thistab.get_selection() if f.is_file], edit="edit", picker=True)',
        ["<C-t>"] = "NvimEdit tabedit",
        ["<C-x>"] = "NvimEdit split",
        ["<C-v>"] = "NvimEdit vsplit",
        ["<C-o>"] = "NvimEdit drop",
        ["gw"] = "JumpNvimCwd",
        ["yw"] = "EmitRangerCwd",
      }
    end,
  },
}
