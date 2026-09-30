{ ... }:

{
  home.file.".config/nvim/lua/config/keymaps.lua".source =
    ../config/nvim/lua/config/keymaps.lua;
  home.file.".config/nvim/lua/plugins/linter.lua".source =
    ../config/nvim/lua/plugins/linter.lua;
  home.file.".config/nvim/lua/plugins/lsp.lua".source =
    ../config/nvim/lua/plugins/lsp.lua;
  home.file.".config/nvim/lua/plugins/rnvimr.lua".source =
    ../config/nvim/lua/plugins/rnvimr.lua;

  programs.lazyvim.enable = true;

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
  '';
}
