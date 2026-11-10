{ pkgs, ... }:

let
  parUnicode = pkgs.par.overrideAttrs (old: {
    version = "1.52-i18n.4";
    src = pkgs.fetchzip {
      url = "https://github.com/ccjmne/par/archive/56c5d7aa2bce3a257b16e99bfa2173b5c551b06b.tar.gz";
      hash = "sha256-vFIxZdl5y3A/2fDNt+AqmXixCiSG//SMh3+WQiH7oyE=";
    };
    makefile = "Makefile";
  });
in
{
  home.packages = with pkgs; [
    # LazyVim tools
    lazygit
    fzf
    parUnicode
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
