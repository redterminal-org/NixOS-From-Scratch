{ ... }:

{
  programs.lazyvim.plugins = {
      gopherSyntax = ''
        return {
          "pinpox/vim-gopher-syntax",
        }
      '';

      linter = ''
        return {
          {
            "mfussenegger/nvim-lint",
            opts = {
              linters_by_ft = {
                sh = { "shellcheck" },
                bash = { "shellcheck" },
                nix = { "statix" },
              },
            },
          },
        }
      '';

      lsp = ''
        return {
          {
            "neovim/nvim-lspconfig",
            opts = {
              servers = {
                lua_ls = {},
                bashls = {},
                nil_ls = {
                  settings = {
                    ["nil"] = {
                      nix = {
                        flake = {
                          autoArchive = false,
                        },
                      },
                    },
                  },
                },
              },
            },
          },
        }
      '';

      filetypes = ''
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
                  vim.opt_local.shiftwidth = 4
                  vim.opt_local.softtabstop = 4
                  vim.opt_local.textwidth = 67
                  vim.opt_local.cc = "67"
                end,
              })

              vim.api.nvim_create_autocmd("FileType", {
                pattern = "gemtext",

                callback = function()
                  vim.opt_local.expandtab = false
                  vim.opt_local.tabstop = 4
                  vim.opt_local.shiftwidth = 4
                  vim.opt_local.softtabstop = 4
                  vim.opt_local.textwidth = 0
                  vim.opt_local.cc = "0"
                  vim.opt_local.wrap = true
                end,
              })
            end,
          },
        }
      '';
  };
}
