vim.notify("filetypes.lua geladen")

return {
  {
    "LazyVim/LazyVim",
    opts = function()
      vim.filetype.add({
        filename = {
          ["gophermap"] = "gopher",
        },
        extension = {
          gph = "gopher",
          gmi = "gemtext",
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "gopher",
        callback = function()
          vim.opt_local.expandtab = false
          vim.opt_local.tabstop = 4
          vim.opt_local.textwidth = 67
          vim.opt_local.cc = 67
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "gemtext",
        callback = function()
          vim.opt_local.expandtab = false
          vim.opt_local.tabstop = 4
          vim.opt_local.textwidth = 0
          vim.opt_local.cc = 0
          vim.opt_local.wrap = true
        end,
      })
    end,
  },
}
