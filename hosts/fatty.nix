{
  imports = [
    ../real.nix
    ../hardware/fatty.nix
  ];

  networking.hostName = "fatty";

  boot.loader.systemd-boot.extraInstallCommands = ''
    if ! bootctl set-default 'nixos-generation-*-specialisation-ollama.conf'; then
      echo "warning: Ollama specialisation boot entry not found; keeping the NixOS default"
    fi
  '';
}
