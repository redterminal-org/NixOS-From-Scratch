{ lazyvim, ... }:

{
  imports = [
    lazyvim.homeManagerModules.default

    ./modules/home-shell.nix
    ./modules/home-ssh-gpg.nix
    ./modules/home-private.nix
    ./modules/home-applications.nix
    ./modules/home-desktop.nix
    ./modules/lazyvim
    ./modules/home-packages.nix
  ];

  home.username = "daniel";
  home.homeDirectory = "/home/daniel";
  home.stateVersion = "26.05";
}
