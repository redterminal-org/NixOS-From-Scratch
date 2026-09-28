{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # LazyVim tools
    lazygit
    fzf
    par
    nixfmt

    # Runtime for LazyVim plugins / tooling
    nodejs

    # Compiler required by native Neovim plugins
    gcc

    # Language servers
    lua-language-server
    pyright
    shfmt
    nil

    # Linters
    shellcheck
  ];
}
