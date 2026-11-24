{
  imports = [
    ../real.nix
    ../hardware/sleepy.nix
  ];

  networking.hostName = "sleepy";
  networking.hostId = "8ac6b7fc";
}
