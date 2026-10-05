{ lib, ... }:

{
  home.file.".config/nvim/lua/config/keymaps.lua".source = ../config/nvim/lua/config/keymaps.lua;
  home.file.".config/nvim/lua/config/options.lua".source = ../config/nvim/lua/config/options.lua;
  home.file.".config/nvim/lua/plugins/gopher-syntax.lua".source =
    ../config/nvim/lua/plugins/gopher-syntax.lua;
  home.file.".config/nvim/lua/plugins/linter.lua".source = ../config/nvim/lua/plugins/linter.lua;
  home.file.".config/nvim/lua/plugins/lsp.lua".source = ../config/nvim/lua/plugins/lsp.lua;
  home.file.".config/nvim/lua/plugins/find-vimwiki-words.lua".source =
    ../config/nvim/lua/plugins/find-vimwiki-words.lua;
  home.file.".config/nvim/lua/plugins/goyo.lua".source = ../config/nvim/lua/plugins/goyo.lua;
  home.file.".config/nvim/lua/plugins/ultisnips.lua".source =
    ../config/nvim/lua/plugins/ultisnips.lua;
  home.file.".config/nvim/lua/plugins/vimwiki.lua".source = ../config/nvim/lua/plugins/vimwiki.lua;
  home.file.".config/nvim/lua/plugins/colorscheme.lua".source =
    ../config/nvim/lua/plugins/colorscheme.lua;
  home.file.".config/nvim/lua/plugins/gen.lua".source = ../config/nvim/lua/plugins/gen.lua;
  home.file.".config/nvim/lua/plugins/codecompanion.lua".source =
    ../config/nvim/lua/plugins/codecompanion.lua;

  # Copy UltiSnips if they don't already exist
  home.activation.installUltiSnips = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD mkdir -p "$HOME/.config/nvim/UltiSnips"
    $DRY_RUN_CMD cp -rn \
      ${../config/nvim/UltiSnips}/. \
      "$HOME/.config/nvim/UltiSnips/"
  '';

  programs.lazyvim = {
    enable = true;

    plugins.yazi = ''
      return {
        "mikavilpas/yazi.nvim",
        version = "*",
        event = "VeryLazy",
        dependencies = {
          { "nvim-lua/plenary.nvim", lazy = true },
        },
        keys = {
          {
            "<leader>r",
            mode = { "n", "v" },
            "<cmd>Yazi<cr>",
            desc = "Open Yazi",
          },
        },
        opts = {
          open_for_directories = false,
          open_multiple_tabs = false,
          config_home = vim.fn.fnamemodify(vim.fn.stdpath("config"), ":h")
            .. "/yazi-lazyvim",
          floating_window_scaling_factor = 0.85,
          yazi_floating_window_winblend = 0,
          yazi_floating_window_border = "rounded",
        },
      }
    '';

    plugins.snacks = ''
      return {
        {
          "folke/snacks.nvim",
          opts = {
            lazygit = {
              configure = false,
            },
          },
        },
      }
    '';

    plugins.filetypes = ''
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
