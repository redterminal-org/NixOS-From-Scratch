{
  imports = [
    ../real.nix
    ../hardware/grumpy.nix
  ];

  networking.hostName = "grumpy";
  networking.hostId = "37fb6c2d";
}
