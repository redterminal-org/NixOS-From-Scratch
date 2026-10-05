{
  imports = [
    ../real.nix
    ../hardware/sleepy.nix
  ];

  networking.hostName = "sleepy";
  networking.hostId = "8ac6b7fc";

  boot.loader.systemd-boot.extraInstallCommands = ''
    if ! bootctl set-default 'nixos-generation-*-specialisation-ollama.conf'; then
      echo "warning: Ollama specialisation boot entry not found; keeping the NixOS default"
    fi
  '';
}
