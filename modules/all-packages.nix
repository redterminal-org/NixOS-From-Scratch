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
    killall
    jq
    pv
    sshfs
    gdu
    wev
    gnupg
    starship
    zfs
    sane-backends # scanimage Package

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
