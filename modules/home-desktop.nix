{ config, lib, pkgs, osConfig, ... }:

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
    custom:rctrl_mod4 = +custom(rctrl_mod4)
  '';

  home.file.".config/kdeglobals".text = ''
    [UiSettings]
    ColorScheme=qt6ct
  '';

  stylix.targets.gtk.enable = true;
  stylix.targets.qt.enable = true;
  stylix.targets.kitty.enable = false;

  home.file.".config/user-dirs.conf".text = ''
    enabled=True
  '';

  home.activation.updateXdgUserDirs =
    config.lib.dag.entryAfter [ "linkGeneration" ] ''
      export LANG="${osConfig.i18n.defaultLocale}"
      export LC_ALL="${osConfig.i18n.defaultLocale}"

      ${pkgs.xdg-user-dirs}/bin/xdg-user-dirs-update --force

      download_dir="$(${pkgs.xdg-user-dirs}/bin/xdg-user-dir DOWNLOAD)"
      if [ "$download_dir" != "$HOME/Downloads" ] && [ -d "$download_dir" ]; then
        rmdir "$download_dir" 2>/dev/null || true
      fi

      ${pkgs.xdg-user-dirs}/bin/xdg-user-dirs-update --set DOWNLOAD "$HOME/Downloads"
      mkdir -p "$HOME/Downloads"
    '';
}
