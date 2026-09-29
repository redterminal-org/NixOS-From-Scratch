# NixOS-From-Scratch v1.0.0 - NixOS 26.05

A modular NixOS configuration built from scratch with a focus on reproducibility, a clean separation between system and user configuration, and a Wayland desktop environment based on Hyprland.

The configuration includes NixOS 26.05, Home Manager, Hyprland, Waybar, Wofi, SwayNC, LazyVim, PipeWire, NetworkManager, GPG and SSH integration, as well as separate configurations for the real system and a regression VM.

**Mirrors:** \
[https://github.com/redterminal-org/NixOS-From-Scratch](https://github.com/redterminal-org/NixOS-From-Scratch) \
[https://codeberg.org/fab/NixOS-From-Scratch](https://codeberg.org/fab/NixOS-From-Scratch)

---

**!!! WARNING !!!**

This is mainly for my personal learning purposes but can be used for learning and testing by others as well. This is my **first** try with NixOS, so don't expect too much.

I expect you to have a basic knowledge on how to set up a basic NixOS system from the NixOS installer, like creating a partition layout and do a basic `nixos-generate-config` on your mounted filesystem.

You can use the Discussion section on the Github repository, if you have problems or questions related to this NixOS configuration. You can also use the Issue Tracker on the Github and Codeberg.org, if you found a problem.

---

## Adapt the Configuration

This configuration is intended as a starting point. It can be used as it is but the system should be adapted to your own needs before use.

The following settings should be reviewed and adjusted:

- **Locale and keyboard layout (currently german)**
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

## Packaged Software

### System

- `wget`: Command-line file downloader
- `curl`: Command-line data transfer tool
- `git`: Distributed version control system
- `bat`: Cat replacement with syntax highlighting
- `eza`: Modern replacement for `ls`
- `htop`: Interactive process viewer
- `maim`: Screenshot utility
- `acpi`: Battery and power information tool
- `ripgrep`: Fast recursive search tool
- `lsof`: Lists open files and processes
- `tree`: Directory tree viewer
- `inetutils`: Network utilities
- `bsd-finger`: User information utility
- `brightnessctl`: Screen brightness control
- `jq`: Command-line JSON processor
- `wev`: Wayland input event viewer
- `wofi`: Wayland application launcher
- `waybar`: Wayland status bar
- `hyprpaper`: Hyprland wallpaper utility
- `dolphin`: KDE file manager
- `snip`: Wayland screenshot utility
- `grim`: Wayland screenshot tool
- `slurp`: Wayland region selection tool
- `wl-clipboard`: Wayland clipboard utilities

### User Applications

- `pass`: Unix password manager
- `pass-otp`: One-time password extension for `pass`
- `oath-toolkit`: Tools for one-time password authentication
- `alacritty`: GPU-accelerated terminal emulator
- `kitty`: GPU-accelerated terminal emulator
- `ranger`: Console file manager
- `qutebrowser`: Keyboard-focused web browser
- `librewolf`: Privacy-focused web browser
- `freetube`: Privacy-focused YouTube client
- `neomutt`: Terminal mail client
- `urlscan`: URL extraction and selection tool
- `elinks`: Text-based web browser
- `mpv`: Media player
- `zathura`: Lightweight document viewer
- `wtype`: Wayland keyboard input tool
- `pipx`: Installer and runner for Python applications
- `gemget`: Command-line Gemini client
- `rogallo`: TUI Gemini Client
- `libnotify`: Desktop notification library
- `swaynotificationcenter`: Wayland notification center
- `todo-txt-cli`: Command-line todo.txt manager
- `starship`: Cross-shell prompt
- `rofimoji`: Emoji and Unicode character picker

### Development Tools

- `lazygit`: Terminal UI for Git
- `fzf`: Command-line fuzzy finder
- `par`: Paragraph reformatter
- `nixfmt`: Nix code formatter
- `nodejs`: JavaScript runtime
- `gcc`: GNU Compiler Collection
- `lua-language-server`: Lua language server
- `pyright`: Python language server and type checker
- `shfmt`: Shell script formatter
- `nil`: Nix language server
- `shellcheck`: Shell script static analyzer
- `LazyVim`: Neovim configuration framework

### Desktop and System Services

- `Hyprland`: Wayland compositor
- `ly`: TUI display manager
- `PipeWire`: Audio and multimedia server
- `NetworkManager`: Network management service
- `GnuPG`: Encryption and digital signature suite
- `gpg-agent`: GnuPG authentication agent
- `pinentry-qt`: Qt graphical PIN entry program
- `SwayNC`: Wayland notification center
- `Home Manager`: Declarative user environment manager

### Fonts

- `JetBrains Mono Nerd Font`: Monospaced programming font with Nerd Font icons

### Editor

- `Neovim`: Extensible terminal-based text editor
- `LazyVim`: Neovim configuration framework

### Shell

- `Bash`: Bourne Again Shell
- `McFly`: Shell history search tool
- `Starship`: Cross-shell prompt

### Authentication and Secrets

- `GnuPG`: OpenPGP encryption and signing
- `pass`: Command-line password manager
- `pass-otp`: One-time password support for `pass`
- `SSH`: Secure remote access and authentication

### Importing Secrets

Private data is not stored in the Nix configuration or Nix store. It can be imported interactively from an SSH server during the first login.

1. Make sure the SSH server is reachable from the NixOS system.
2. Start Hyprland and log in as the configured user.
3. The private-data import service starts automatically.
4. Enter the SSH destination when prompted:
   - `user@server`
5. Enter the path to the Secrets directory when prompted.
6. The script downloads the directory and imports the contained GPG keys, SSH keys, password store and the rogallo Client Certificates, bookmarks, history and so on.

The Secrets directory on the SSH server must have the following structure:

    secrets/
    ├── gnupg/
    │   ├── public.asc
    │   └── secret.asc
    ├── ssh/
    │   ├── id_*
    │   └── *.pub
    ├── password-store/
    │   └── ...
    └── rogallo/
        ├── bookmarks.json
        ├── client_certificates/
        ├── command-history.json
        ├── known_hosts
        ├── location-history.json
        └── navigation-history.json

The directory name itself is arbitrary. Its path is entered during the import process.

The imported data is copied to:

    ~/.gnupg/
    ~/.ssh/
    ~/.password-store/
    ~/.local/share/rogallo/

The GPG keys are imported into the user's local GPG keyring.

If the import is intentionally skipped, a marker is created so that the user is not asked again. If the import fails before completion, no success marker is created and the import can be attempted again at the next login.

## License

Copyright (C) 2026 fab@redterminal.org

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3 only.
