{ pkgs, ... }:
{
  imports = [
    ../real.nix
    ../hardware/fatty.nix
  ];

  networking.hostName = "fatty";

  specialisation.ollama.configuration = {
    services.ollama.package = pkgs.ollama-rocm;

    systemd.services.ollama = {
      after = [
        "dev-kfd.device"
        "dev-dri-renderD128.device"
      ];

      wants = [
        "dev-kfd.device"
        "dev-dri-renderD128.device"
      ];
    };
  };

  boot.loader.systemd-boot.extraInstallCommands = ''
    if ! bootctl set-default 'nixos-generation-*-specialisation-ollama.conf'; then
      echo "warning: Ollama specialisation boot entry not found; keeping the NixOS default"
    fi
  '';
}
