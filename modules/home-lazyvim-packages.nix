{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # LazyVim tools
    lazygit
    fzf
    par
    nixfmt
    rustfmt

    # Runtime for LazyVim plugins / tooling
    nodejs

    # Compiler required by native Neovim plugins
    gcc

    # Language servers
    lua-language-server
    pyright
    shfmt
    nil
    gopls
    rust-analyzer
    ruff

    # Linters
    shellcheck
    golangci-lint
    clippy
    markdownlint-cli2
  ];
}
