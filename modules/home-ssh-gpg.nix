{ config, pkgs, ... }:

{
  services.ssh-agent = {
    enable = true;
    defaultMaximumIdentityLifetime = 86400;
  };

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-qt;

    defaultCacheTtl = 86400;
    maxCacheTtl = 86400;
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
