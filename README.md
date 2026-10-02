# NixOS-From-Scratch - NixOS 26.05

A modular NixOS configuration built from scratch with a focus on a clean separation between system and user configuration, and a Wayland desktop environment based on Hyprland.

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

## NixOS Outputs

The flake provides four NixOS configurations. The standard outputs do not include Ollama, while the `ollama` outputs enable the Ollama service.

### `.#nixos`

Normal NixOS installation without Ollama.

```bash
sudo nixos-rebuild switch --flake .#nixos
```

### `.#ollama`

NixOS installation with Ollama enabled.

```bash
sudo nixos-rebuild switch --flake .#ollama
```

The LLM used by the LazyVim `gen.nvim` translation integration must be downloaded manually after installation:

```bash
ollama pull translategemma:12b
```

LazyVim provides the following translation prompts:

- `Translate to German`
- `Translate to English`

The selected text is replaced with the generated translation.

### `.#vm`

Interactive regression VM without Ollama.

```bash
nixos-rebuild build-vm-with-bootloader --flake .#vm
```

### `.#ollama-vm`

Interactive regression VM with Ollama enabled.

```bash
nixos-rebuild build-vm-with-bootloader --flake .#ollama-vm
```

The LLM used by the LazyVim `gen.nvim` translation integration must be downloaded manually in the VM:

```bash
ollama pull translategemma:12b
```

LazyVim provides the following translation prompts:

- `Translate to German`
- `Translate to English`

The selected text is replaced with the generated translation.

## Key Bindings

The following are the most important key bindings configured in `config/hypr/hyprland.lua`.

`SUPER` refers to the `Super`/Windows key. The right `CTRL` key is additionally configured as `Super_R`.

### Applications

| Key | Action |
| --- | --- |
| `SUPER + Enter` | Open Kitty terminal |
| `SUPER + E` | Open Dolphin file manager |
| `SUPER + D` | Open application launcher |
| `SUPER + R` | Reload Waybar |
| `SUPER + S` | Take a screenshot |
| `SUPER + P` | Open password menu |
| `SUPER + O` | Open one-time-password menu |
| `SUPER + M` | Open radio menu |
| `SUPER + .` | Open emoji picker |
| `F12` | Toggle dropdown terminal |

### Window Management

| Key | Action |
| --- | --- |
| `SUPER + Q` | Close active window |
| `SUPER + V` | Toggle floating mode |
| `SUPER + CTRL + Q` | Exit Hyprland |
| `SUPER + Arrow` | Move focus |
| `SUPER + H/J/K/L` | Move active window |
| `SUPER + SHIFT + Arrow` | Resize active window |
| `SUPER + Left Mouse` | Move active window |
| `SUPER + Right Mouse` | Resize active window |

### Workspaces

| Key | Action |
| --- | --- |
| `SUPER + 1–9` | Switch to workspace 1–9 |
| `SUPER + 0` | Switch to workspace 10 |
| `SUPER + SHIFT + 1–9` | Move active window to workspace 1–9 |
| `SUPER + SHIFT + 0` | Move active window to workspace 10 |
| `SUPER + Mouse Wheel` | Switch between existing workspaces |

### Media and Hardware

| Key | Action |
| --- | --- |
| `XF86MonBrightnessUp` | Increase screen brightness |
| `XF86MonBrightnessDown` | Decrease screen brightness |
| `XF86AudioRaiseVolume` | Increase volume |
| `XF86AudioLowerVolume` | Decrease volume |
| `XF86AudioMute` | Toggle audio mute |

The complete key binding configuration can be found in `config/hypr/hyprland.lua`.

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
- `kitty`: GPU-accelerated terminal emulator
- `yazi`: Terminal file manager
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
6. The script downloads the directory and imports the contained GPG keys, SSH keys, password store and Rogallo data.

#### GPG Keys

The `gnupg/public.asc` file contains the exported public GPG keys, while `gnupg/secret.asc` contains the exported private GPG keys. Both files are mandatory.

They can be created from an existing GPG keyring with:

```bash
gpg --armor --export > public.asc
gpg --armor --export-secret-keys > secret.asc
```

The public key file can be distributed freely, while the secret key file contains private key material and must be protected accordingly.

The files must be placed in the `gnupg/` directory of the Secrets directory.

#### SSH, Password Store and Rogallo Data

The `ssh/`, `password-store/` and `rogallo/` directories are copied to the corresponding locations in the user's home directory. Their contents are generally optional and can contain only the files that are actually needed.

The `ssh/` directory can contain multiple SSH key pairs as well as other SSH configuration files such as `known_hosts` or `authorized_keys`:

```text
ssh/
├── id_ed25519
├── id_ed25519.pub
├── id_work
├── id_work.pub
├── authorized_keys
└── known_hosts
```

The `password-store/` directory contains the initial passwords for the password store. It can also contain One-Time-Password secrets in `password-store/otp/`. These OTP secrets use the following format:

```text
otpauth://totp/<name>?secret=<secret>&issuer=<issuer>
```

For example:

```text
password-store/
├── example.gpg
├── another-password.gpg
└── otp/
    └── example
```

The `rogallo/` directory does not have to contain all available Rogallo data. For example, it can contain only the client certificates:

```text
rogallo/
└── client_certificates/
```

Other files such as bookmarks, command history or navigation history can be omitted if they are not needed.

The Secrets directory on the SSH server must therefore contain at least the following GPG files:

```text
secrets/
├── gnupg/
│   ├── public.asc
│   └── secret.asc
├── ssh/
│   └── ...
├── password-store/
│   └── ...
└── rogallo/
    └── ...
```

Only `gnupg/public.asc` and `gnupg/secret.asc` are mandatory. The `ssh/`, `password-store/` and `rogallo/` directories can contain any supported data or can be empty if that particular data is not required.

The directory name itself is arbitrary. Its path is entered during the import process.

The imported data is copied to:

```text
~/.gnupg/
~/.ssh/
~/.password-store/
~/.local/share/rogallo/
```

The GPG keys are imported into the user's local GPG keyring.

If the import is intentionally skipped, a marker is created so that the user is not asked again. If the import fails before completion, no success marker is created and the import can be attempted again at the next login.

## License

Copyright (C) 2026 fab@redterminal.org

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3 only.
