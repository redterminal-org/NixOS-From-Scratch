{ lazyvim, ... }:

{
  imports = [
    lazyvim.homeManagerModules.default

    ./home-shell.nix
    ./home-lazyvim.nix
    ./home-lazyvim-packages.nix
  ];

  home.stateVersion = "26.05";
}
