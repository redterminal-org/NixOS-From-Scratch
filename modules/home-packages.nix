{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Tools & Apps
    (pass.withExtensions (exts: [
      exts.pass-otp
    ]))
    oath-toolkit

    alacritty
    kitty
    yazi
    qutebrowser
    librewolf
    freetube
    neomutt
    urlscan
    elinks
    mpv
    zathura
    wtype
    pipx
    gemget

    # Notification System
    libnotify
    swaynotificationcenter

    # Gadgets
    todo-txt-cli
    starship
    rofimoji
  ];

  # Rogallo Install / Upgrade
  home.activation.updatePipxPackages =
    config.lib.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.pipx}/bin/pipx upgrade rogallo || ${pkgs.pipx}/bin/pipx install rogallo
    '';
}
