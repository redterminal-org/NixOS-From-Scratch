{ config, ... }:

{
  services.swaync.enable = true;

  home.file.".config/hypr".source = ../config/hypr;
  home.file.".config/waybar".source = ../config/waybar;
  home.file.".config/swaync".source = ../config/swaync;

  home.file.".config/wofi".source = ../config/wofi;

  home.activation.makeWofiScriptsExecutable =
    config.lib.dag.entryAfter [ "writeBoundary" ] ''
      if [ -d "$HOME/.config/wofi" ]; then
        find "$HOME/.config/wofi" -type f -name "*.sh" -exec chmod 700 {} +
      fi
    '';

  home.file."bin".source = ../config/bin;

  home.file.".config/xkb/symbols/custom".source =
    ../config/xkb/custom;

  home.file.".config/xkb/rules/evdev".text = ''
    ! include %S/evdev

    ! option = symbols
    custom:print_mod4 = +custom(print_mod4)
  '';

  home.file.".config/kdeglobals".text = ''
    [UiSettings]
    ColorScheme=qt6ct
  '';

  qt = {
    enable = true;

    platformTheme.name = "qtct";
    style.name = "adwaita-dark";

    qt6ctSettings = {
      Appearance = {
        style = "adwaita-dark";
      };
    };
  };
}
