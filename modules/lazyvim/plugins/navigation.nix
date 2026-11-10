{ ... }:

{
  programs.lazyvim.plugins = {
      findVimwikiWords = ''
        return {
          {
            "fab/find-vimwiki-words.nvim",
            url = "https://codeberg.org/fab/find-vimwiki-words.nvim.git",
            lazy = false,
            dependencies = {
              "vimwiki/vimwiki",
              "nvim-telescope/telescope.nvim",
            },
            keys = {
              {
                "<leader>tw",
                function()
                  require("find-vimwiki-words").find_vimwiki_words()
                end,
                desc = "Telescope Find VimWiki words",
              },
            },
          },
        }
      '';

      yazi = ''
        return {
          "mikavilpas/yazi.nvim",
          version = "*",
          event = "VeryLazy",

          dependencies = {
            {
              "nvim-lua/plenary.nvim",
              lazy = true,
            },
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

            config_home =
              vim.fn.fnamemodify(
                vim.fn.stdpath("config"),
                ":h"
              ) .. "/yazi-lazyvim",

            floating_window_scaling_factor = 0.85,
            yazi_floating_window_winblend = 0,
            yazi_floating_window_border = "rounded",

            open_file_function = function(chosen_file, config, state)
              if chosen_file:lower():match("%.pdf$") then
                vim.fn.jobstart({ "zathura", chosen_file }, {
                  detach = true,
                })
                return
              end

              -- Preserve the plugin's default behavior for other files.
              vim.cmd.edit(vim.fn.fnameescape(chosen_file))
            end,
          },
        }
      '';

      snacks = ''
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
