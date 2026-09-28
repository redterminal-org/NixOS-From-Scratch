# NixOS-From-Scratch v1.0.0 - NixOS 26.05

A modular NixOS configuration built from scratch with a focus on reproducibility, a clean separation between system and user configuration, and a Wayland desktop environment based on Hyprland.

The configuration includes NixOS 26.05, Home Manager, Hyprland, Waybar, Wofi, SwayNC, LazyVim, PipeWire, NetworkManager, GPG and SSH integration, as well as separate configurations for the real system and a regression VM.

---

**!!! WARNING !!!**
This is mainly for my personal learning purposes but can be used for learning and testing by others as well. This is my **first** try with NixOS, so don't expect too much.

I expect you to have a basic knowledge on how to set up a basic NixOS system from the NixOS installer, like creating a partition layout and do a basic `nixos-generate-config` on your mounted filesystem.

You can use the Discussion section of this Repository, if you have problems or questions related to this NixOS configuration. Please leave the Issue tracker clean for my personal changes.

---

## Adapt the Configuration

This configuration is intended as a starting point. It can be used as it is but the system should be adapted to your own needs before use.

The following settings should be reviewed and adjusted:

- **Locale and keyboard layout**
  - Edit `modules/all-localization.nix`.
  - Adjust `time.timeZone` to your time zone.
  - Adjust `i18n.defaultLocale` to your preferred locale.
  - Adjust `console.keyMap` to your keyboard layout.
  - The Hyprland keyboard layout can be adjusted in `config/hypr/hyprland.lua`.

- **User configuration**
  - Edit `modules/all-user.nix` to change the default user.
  - Update `home.nix` with the corresponding `home.username` and `home.homeDirectory`.

- **Hardware configuration**
  - Replace `hardware-configuration.nix` with the hardware configuration generated for your machine.
  - Review `real.nix` and adjust the boot configuration if necessary.

- **Hostname**
  - Change `networking.hostName` in `real.nix`.

- **Packages and applications**
  - Adjust `modules/all-packages.nix` for system-wide packages.
  - Adjust `modules/home-packages.nix` for user packages.

- **Hyprland**
  - Adjust `config/hypr/hyprland.lua` to your monitors, keybindings, applications, input devices and preferred appearance.

- **VM configuration**
  - Review `vm.nix` if the regression VM is used.
  - Adjust memory, CPU, disk size and other VM settings to your requirements.

### Importing Secrets

Private data is not stored in the Nix configuration or Nix store. It can be imported interactively from an SSH server during the first login.

1. Make sure the SSH server is reachable from the NixOS system.
2. Start Hyprland and log in as the configured user.
3. The private-data import service starts automatically.
4. Enter the SSH destination when prompted:
   - `user@server`
5. Enter the path to the Secrets directory when prompted.
6. The script downloads the directory and imports the contained GPG keys, SSH keys and password store.

The Secrets directory on the SSH server must have the following structure:

```text
secrets/
├── gnupg/
│   ├── public.asc
│   └── secret.asc
├── ssh/
│   ├── id_*
│   └── *.pub
└── password-store/
    └── ...
```

The directory name itself is arbitrary. Its path is entered during the import process.

The imported data is copied to:

```text
~/.gnupg/
~/.ssh/
~/.password-store/
```

The GPG keys are imported into the user's local GPG keyring.

If the import is intentionally skipped, a marker is created so that the user is not asked again. If the import fails before completion, no success marker is created and the import can be attempted again at the next login.

## License

Copyright (C) 2026 fab@redterminal.org

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3 only.
