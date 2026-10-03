{ config, lazyvim, ... }:

{
  imports = [
    lazyvim.homeManagerModules.default

    ./home-shell.nix
    ./home-lazyvim.nix
    ./home-lazyvim-packages.nix
  ];

  home.activation.ensureGnuPGDirectory =
    config.lib.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p "$HOME/.gnupg"
      chmod 700 "$HOME/.gnupg"
    '';

  home.file.".config/starship.toml".source = ../config/starship.toml;

  home.stateVersion = "26.05";
}
