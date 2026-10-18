{ ... }:

{
  services.ollama.enable = true;
  systemd.services.ollama.restartIfChanged = false;
}
