{
  imports = [
    ../real.nix
    ../hardware/sleepy.nix
  ];

  networking.hostName = "sleepy";

  boot.loader.systemd-boot.extraInstallCommands = ''
    bootctl set-default "$(basename "$(ls -1 /boot/loader/entries/nixos-generation-*-specialisation-ollama.conf | sort -V | tail -n1)")"
  '';
}
