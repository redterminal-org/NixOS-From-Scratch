{ ... }:

{
  imports = [
    ./modules/system
    ./modules/desktop
    ./modules/hardware
    ./modules/development
    ./modules/services
    ./modules/packages
  ];

  system.stateVersion = "26.05";
}
