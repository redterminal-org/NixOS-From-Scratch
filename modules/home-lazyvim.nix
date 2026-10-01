{ ... }:

{
  home.file.".config/nvim/lua/config/keymaps.lua".source = ../config/nvim/lua/config/keymaps.lua;
  home.file.".config/nvim/lua/plugins/linter.lua".source = ../config/nvim/lua/plugins/linter.lua;
  home.file.".config/nvim/lua/plugins/lsp.lua".source = ../config/nvim/lua/plugins/lsp.lua;
  home.file.".config/nvim/lua/plugins/colorscheme.lua".source =
    ../config/nvim/lua/plugins/colorscheme.lua;

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
          floating_window_scaling_factor = 0.9,
          yazi_floating_window_winblend = 0,
          yazi_floating_window_border = "rounded",
        },
      }
    '';
  };

  home.file.".config/lazygit/config.yml".text = ''
    customCommands:
      - key: "<c-y>"
        context: "global"
        description: "Push current branch to all remotes"
        command: |
          branch="$(git branch --show-current)" &&
          for remote in $(git remote); do
            echo "Pushing $branch to $remote..."
            git push "$remote" "$branch" || exit 1
          done
        loadingText: "Pushing to all remotes..."
        output: terminal

    gui:
      theme:
        activeBorderColor:
          - '#f8e45c'
          - bold
        inactiveBorderColor:
          - '#77767b'
        searchingActiveBorderColor:
          - '#78aeed'
          - bold
        optionsTextColor:
          - '#78aeed'
        selectedLineBgColor:
          - '#353535'
        inactiveViewSelectedLineBgColor:
          - '#2b2b2b'
        cherryPickedCommitFgColor:
          - '#62a0ea'
        cherryPickedCommitBgColor:
          - '#303030'
        markedBaseCommitFgColor:
          - '#f8e45c'
        markedBaseCommitBgColor:
          - '#303030'
        unstagedChangesColor:
          - '#ed333b'
  '';
}
