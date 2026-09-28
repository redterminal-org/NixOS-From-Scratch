{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos";

  /*
    Boot configuration for the physical machine.
  */
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
