{ config, pkgs, ... }:

{
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-qt;
  };

  programs.gpg = {
    enable = true;
    mutableKeys = true;
    mutableTrust = true;

    settings = {
      auto-key-locate = "wkd,keyserver";
      keyserver = "hkps://keys.openpgp.org/";
      trust-model = "tofu";
      auto-key-retrieve = true;
    };
  };
}
