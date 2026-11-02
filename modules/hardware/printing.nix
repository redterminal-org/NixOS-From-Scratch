{ pkgs, ... }:

{
  nixpkgs.config.allowUnfreePackages = [
    "brscan4"
    "brscan4-etc-files"
    "brother-udev-rule-type1"
  ];

  services.printing = {
    enable = true;
    drivers = [
      pkgs.brlaser
    ];
  };

  hardware.sane = {
    enable = true;

    brscan4 = {
      enable = true;

      netDevices.MFC-1910W = {
        model = "MFC-1910W";
        ip = "192.168.70.207";
      };
    };
  };
}
