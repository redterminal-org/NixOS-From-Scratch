{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.hyprlock
  ];

  security.pam.services.hyprlock = { };

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };
}
