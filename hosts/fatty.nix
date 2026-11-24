{ pkgs, ... }:
{
  imports = [
    ../real.nix
    ../hardware/fatty.nix
  ];

  networking.hostName = "fatty";
  networking.hostId = "7c4e91a2";

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

  security.sudo.extraRules = [
    {
      groups = [ "wheel" ];
      commands = [
        {
          command = "${pkgs.zfs}/bin/zfs list";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.zfs}/bin/zfs receive";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
