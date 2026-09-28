{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Tools & Apps
    (pass.withExtensions (exts: [
      exts.pass-otp
    ]))
    oath-toolkit

    alacritty
    ranger
    qutebrowser
    librewolf
    freetube
    neomutt
    urlscan
    elinks
    mpv

    # Notification System
    libnotify
    swaynotificationcenter

    # Gadgets
    todo-txt-cli
    starship
  ];
}
