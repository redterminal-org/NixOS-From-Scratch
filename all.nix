{ pkgs, ... }:

{
  imports = [
    ./modules/all-network.nix
    ./modules/all-localization.nix
    ./modules/all-audio.nix
    ./modules/all-wayland.nix
    ./modules/all-hyprland.nix
    ./modules/all-hyprlock.nix
    ./modules/all-user.nix
    ./modules/all-packages.nix
    ./modules/all-fonts.nix
    ./modules/all-nix.nix
    ./modules/all-printing.nix
    ./modules/all-zfs.nix
    ./modules/all-esp32-dev.nix
  ];

  stylix = {
    enable = true;
    autoEnable = false;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";
  };

  system.stateVersion = "26.05";
}
