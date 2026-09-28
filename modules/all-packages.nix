{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    bat
    eza
    htop
    maim
    acpi
    ripgrep
    lsof
    tree
    inetutils
    bsd-finger
    brightnessctl
    jq
    wev

    # Hyprland tools
    wofi
    waybar
    hyprpaper
    kdePackages.dolphin
    snip

    # Wayland tools
    grim
    slurp
    wl-clipboard
  ];
}
