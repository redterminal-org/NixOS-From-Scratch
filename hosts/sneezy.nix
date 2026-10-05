{
  imports = [
    ../real.nix
    ../hardware/sneezy.nix
  ];

  networking.hostName = "sneezy";
  networking.hostId = "c9f29a5c";
}
