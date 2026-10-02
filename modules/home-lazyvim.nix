{ ... }:

{
  home.file.".config/nvim/lua/config/keymaps.lua".source = ../config/nvim/lua/config/keymaps.lua;
  home.file.".config/nvim/lua/config/options.lua".source = ../config/nvim/lua/config/options.lua;
  home.file.".config/nvim/lua/plugins/linter.lua".source = ../config/nvim/lua/plugins/linter.lua;
  home.file.".config/nvim/lua/plugins/lsp.lua".source = ../config/nvim/lua/plugins/lsp.lua;
  home.file.".config/nvim/lua/plugins/colorscheme.lua".source =
    ../config/nvim/lua/plugins/colorscheme.lua;
  home.file.".config/nvim/lua/plugins/gen.lua".source =
    ../config/nvim/lua/plugins/gen.lua;
  home.file.".config/nvim/lua/plugins/codecompanion.lua".source =
    ../config/nvim/lua/plugins/codecompanion.lua;

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
  };

}
