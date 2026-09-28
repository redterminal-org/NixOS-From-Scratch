{ ... }:

{
  imports = [
    ./modules/all-network.nix
    ./modules/all-localization.nix
    ./modules/all-audio.nix
    ./modules/all-wayland.nix
    ./modules/all-hyprland.nix
    ./modules/all-user.nix
    ./modules/all-packages.nix
    ./modules/all-fonts.nix
    ./modules/all-nix.nix
  ];

  system.stateVersion = "26.05";
}
