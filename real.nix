{
  /*
    Shared configuration for all physical NixOS installations.
  */
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  /*
    Optional physical-system specialisation with Ollama.

    Every physical machine gets the same optional Ollama configuration,
    so adding another machine does not require another Ollama flake output.
  */
  specialisation.ollama.configuration = {
    imports = [
      ./modules/ollama.nix
    ];
  };

  /*
    Optional physical-system specialisation for ESP32 development.
  */
  specialisation.esp32-dev.configuration = {
    imports = [
      ./modules/esp32-dev.nix
    ];
  };

  /*
    Combined Ollama and ESP32 development specialisation.
  */
  specialisation.ollama-esp32-dev.configuration = {
    imports = [
      ./modules/ollama.nix
      ./modules/esp32-dev.nix
    ];
  };
}
