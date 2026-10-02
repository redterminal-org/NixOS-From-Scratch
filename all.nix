{ pkgs, ... }:

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
    ./modules/all-printing.nix
  ];

  stylix = {
    enable = true;
    autoEnable = false;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
  };

  system.stateVersion = "26.05";
}
