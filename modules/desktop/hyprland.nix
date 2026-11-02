{ ... }:

{
  services.displayManager.ly = {
    enable = true;

    settings = {
      clock = "%c";
      lang = "en";
      bigclock = "en";
      bigclock_12hr = false;
      bigclock_seconds = true;
      session_log = null;
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
