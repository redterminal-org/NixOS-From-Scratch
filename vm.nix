{ pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.growPartition = true;

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  systemd.services.resize-root-filesystem = {
    description = "Resize the root filesystem";

    after = [ "growpart.service" ];
    requires = [ "growpart.service" ];

    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.e2fsprogs}/bin/resize2fs /dev/disk/by-label/nixos";
      RemainAfterExit = true;
    };
  };

  # Use systemd-boot as the bootloader for the VM.
  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  # Use a dedicated hostname for the test VM.
  networking.hostName = "nixos-test";
  networking.hostId = "7854ae63";

  virtualisation.vmVariantWithBootLoader = {
    virtualisation = {
      # VM hardware resources.
      memorySize = 8192;
      cores = 3;

      # Use the standard NixOS VM filesystem layout.
      useDefaultFilesystems = true;

      # Keep the writable Nix store on the VM disk.
      writableStoreUseTmpfs = false;

      # Persistent virtual disk used by the VM.
      diskImage = "./nixos-test-bootloader.qcow2";
      diskSize = 32768;

      # Enable graphical output.
      graphics = true;

      # Use one accelerated VirtIO VGA device.
      qemu.options = [
        "-device"
        "virtio-vga-gl"
        "-display"
        "sdl,gl=on"
        "-device"
        "ich9-intel-hda"
        "-device"
        "hda-duplex"
      ];
    };

    # Set a temporary password for the test user. Default "nixos",
    # but you should set your own with "mkpasswd --method=yescrypt"
    users.users.daniel.hashedPassword = "$y$j9T$AyxrOoeT4L8sOzwxL1KRh.$d2f1DG6FkIqNzBrO0BdqHvsjfND4tI211wYak4oRr2A";
  };
}
